WITH sales AS (
    SELECT
        order_id,
        user_id,
        promos.promo_id,
        promos.promo_desc
    FROM {{ ref("fct_order_items") }} orders
    INNER JOIN {{ ref("dim_promos") }} promos
        ON orders.promo_id = promos.promo_id
    ),

    customers_per_promo AS (
        SELECT 
            COUNT(DISTINCT(user_id)) AS total_customers_per_promo,
            promo_desc
        FROM sales
        GROUP BY promo_desc
    ),

    customers AS (
        SELECT
            COUNT(DISTINCT user_id) AS total_customers
        FROM sales
    )

SELECT 
    promo_desc,
    total_customers_per_promo,
    total_customers,
    ROUND((total_customers_per_promo/total_customers) * 100,2) AS CDR_percentaje
FROM customers tc
CROSS JOIN customers_per_promo tcp
WHERE promo_desc != 'No-promo'
ORDER BY CDR_percentaje DESC

