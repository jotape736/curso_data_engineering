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

    promotional_sales_users AS (
        SELECT
            user_id,
            promo_id
        FROM sales
        WHERE promo_desc != 'No-promo'
    ),

    total_sales_users AS (
        SELECT DISTINCT
            user_id
        FROM sales
    )

SELECT DISTINCT(user_id) FROM promotional_sales_users
    /*s.promo_desc,
    COUNT(psu.user_id) AS customers_with_discount,
    COUNT(tsu.user_id) AS total_customers,
    (COUNT(psu.user_id) / COUNT(tsu.user_id)) * 100 AS CDR
FROM total_sales_users tsu
JOIN promotional_sales_users psu
    ON tsu.user_id = psu.user_id
JOIN sales s
    ON s.promo_id = psu.promo_id
GROUP BY s.promo_desc*/
