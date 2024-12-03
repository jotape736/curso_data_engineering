SELECT
    b.budget_id,
    p.product_desc,
    b.month,
    b.year,
    b.quantity,
    quantity * price_usd AS budget
FROM {{ref("fct_budget")}} b
INNER JOIN {{ref("dim_products")}} p
    ON b.product_id = p.product_id