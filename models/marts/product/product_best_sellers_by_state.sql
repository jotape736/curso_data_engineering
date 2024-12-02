SELECT
    u.state,
    p.product_desc,
    SUM(o.quantity) AS total_quantity,
    DENSE_RANK() OVER (PARTITION BY state ORDER BY total_quantity DESC) AS ranking
FROM {{ref("fct_order_items")}} o
INNER JOIN {{ref("dim_user_data")}} u
    ON o.address_id = u.address_id
INNER JOIN {{ref("dim_products")}} p
    ON o.product_id = p.product_id
GROUP BY o.product_id, u.state, p.product_desc