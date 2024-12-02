SELECT
    p.product_desc,
    COUNT(o.product_id) AS total_products_sold,
    DENSE_RANK() OVER( ORDER BY total_products_sold DESC) AS Ranking
FROM {{ref("fct_order_items")}} o
INNER JOIN {{ref("dim_products")}} p
    ON o.product_id = p.product_id
GROUP BY product_desc