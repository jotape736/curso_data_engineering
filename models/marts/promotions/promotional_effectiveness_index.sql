WITH sales AS (
        SELECT
            order_id,
            order_total_usd,
            promos.promo_id,
            promos.promo_desc
        FROM {{ ref("fct_order_items") }} orders
        INNER JOIN {{ ref("dim_promos") }} promos
            ON orders.promo_id = promos.promo_id
    ),

    promotional_sales AS (
        SELECT
            promo_id,
            promo_desc,
            AVG(order_total_usd) AS avg_promotional_sales_usd
        FROM sales
        WHERE promo_desc != 'No-promo'
        GROUP BY promo_id, promo_desc
    ),

    non_promotional_sales AS (
        SELECT
            AVG(order_total_usd) AS avg_non_promotional_sales_usd
        FROM sales
        WHERE promo_desc = 'No-promo'
    )

SELECT 
    ps.promo_desc,
    ROUND(ps.avg_promotional_sales_usd,2) AS avg_promotional_sales_usd,
    ROUND(nps.avg_non_promotional_sales_usd,2) AS avg_non_promotional_sales_usd,
    ROUND((ps.avg_promotional_sales_usd - nps.avg_non_promotional_sales_usd) / nps.avg_non_promotional_sales_usd * 100, 2) AS PEI
FROM promotional_sales ps
CROSS JOIN non_promotional_sales nps
ORDER BY PEI DESC
