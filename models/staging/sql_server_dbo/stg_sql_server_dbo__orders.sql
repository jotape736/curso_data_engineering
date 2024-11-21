{{
  config(
    materialized='view'
  )
}}

WITH src_orders AS (
    SELECT * 
    FROM {{ source('sql_server_dbo', 'orders') }}
    ),

renamed_casted AS (
    SELECT
        order_id,
        NULLIF(shipping_service,'') AS shipping_service_id,
        shipping_cost AS dollar_shipping_cost,
        address_id,
        CONVERT_TIMEZONE('UTC', created_at) AS created_at,
        NULLIF(promo_id,'') AS promo_id,
        CONVERT_TIMEZONE('UTC', estimated_delivery_at) AS estimated_delivery_at,
        order_cost AS dollar_order_cost,
        user_id,
        order_total AS dollar_order_total,
        CONVERT_TIMEZONE('UTC', delivered_at) AS delivered_at,
        NULLIF(tracking_id,'') AS tracking_id,
        status,
        CONVERT_TIMEZONE('UTC', _fivetran_synced) AS load_date
    FROM src_orders
    )

SELECT
    order_id,
    {{ dbt_utils.generate_surrogate_key(['shipping_service_id']) }} AS shipping_service_id,
    dollar_shipping_cost,
    address_id,
    created_at,
    {{ dbt_utils.generate_surrogate_key(['promo_id']) }} AS promo_id,
    estimated_delivery_at,
    dollar_order_cost,
    user_id,
    dollar_order_total,
    delivered_at,
    tracking_id,
    status,
    load_date
FROM renamed_casted

