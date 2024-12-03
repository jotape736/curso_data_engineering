{{ config(
    unique_key = 'order_id'
    ) 
}}
WITH stg_orders AS (
    SELECT * 
    FROM {{ ref('stg_sql_server_dbo__orders') }}
    ),

    stg_order_items AS (
        SELECT *
        FROM {{ ref('stg_sql_server_dbo__order_items') }}
    ),

    orders AS (
        SELECT
            DENSE_RANK() OVER(ORDER BY orders.order_id) AS DN_RK,
            orders.order_id,
            orders.user_id,
            orders.shipping_service_id,
            orders.shipping_cost_usd,
            orders.order_cost_usd,
            orders.order_total_usd,
            orders.promo_id,
            orders.address_id,
            orders.created_at_utc,
            orders.status_id,
            orders.status_desc,
            orders.estimated_delivery_at_utc,
            orders.delivered_at_utc,
            orders.tracking_id,
            order_items.product_id,
            order_items.quantity,
            orders.days_to_deliver,
            orders.load_date_utc
            FROM stg_orders orders
            INNER JOIN stg_order_items order_items
                ON orders.order_id = order_items.order_id
    )

SELECT
    order_id,
    user_id,
    product_id,
    quantity,
    shipping_service_id,
    shipping_cost_usd,
    order_cost_usd,
    order_total_usd,
    promo_id,
    address_id,
    created_at_utc,
    status_id,
    tracking_id,
    estimated_delivery_at_utc,
    delivered_at_utc,
    days_to_deliver,
    load_date_utc
FROM orders
{% if is_incremental() %}

    WHERE load_date_utc > (select max(load_date_utc) from {{ this }})

{% endif %}