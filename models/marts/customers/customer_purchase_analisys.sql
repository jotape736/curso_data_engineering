WITH order_grain_cte AS (
        SELECT DISTINCT
                user_id,
                order_id,
                SUM(quantity) AS total_quantity_product,
                order_total_usd,
                order_cost_usd,
                shipping_cost_usd,
                discount AS total_discount,
        FROM {{ref("fct_order_items")}} o
        INNER JOIN {{ref("dim_promos")}} p
            ON o.promo_id = p.promo_id
        GROUP BY order_id, user_id, order_total_usd, order_cost_usd, shipping_cost_usd, p.promo_id, p.promo_desc, total_discount
        ORDER BY user_id, order_id ASC
    ),

    user_grain_cte AS (
        SELECT
            user_id,
            COUNT(order_id) AS total_number_orders,
            SUM(order_total_usd) AS total_order_cost_usd,
            SUM(shipping_cost_usd) AS total_shipping_cost_usd,
            SUM(total_discount) AS total_discount_usd,
            SUM(total_quantity_product) AS total_quantity_product,
            
        FROM order_grain_cte
        GROUP BY user_id
    ),

    product_grain_cte AS (
        SELECT DISTINCT
            user_id,
            COUNT(DISTINCT(product_id)) AS total_different_products
        FROM {{ref("fct_order_items")}}
        GROUP BY user_id
    )


SELECT
    u.user_id,
    d.first_name,
    d.last_name,
    d.email,
    d.phone_number,
    d.created_at_utc,
    d.address_desc,
    d.zipcode,
    d.country,
    d.state,
    u.total_number_orders,
    u.total_order_cost_usd,
    u.total_shipping_cost_usd,
    u.total_discount_usd,
    u.total_quantity_product,
    p.total_different_products
FROM user_grain_cte u
INNER JOIN product_grain_cte p
    ON u.user_id = p.user_id
INNER JOIN {{ref("dim_user_data")}} d
    ON u.user_id = d.user_id