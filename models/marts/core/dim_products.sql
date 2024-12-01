WITH stg_products AS (
    SELECT * 
    FROM {{ ref('stg_sql_server_dbo__products') }}
    ),

products AS (
    SELECT
        product_id,
        product_desc,
        price_usd,
        inventory,
        stock
    FROM stg_products
    )

SELECT * FROM products