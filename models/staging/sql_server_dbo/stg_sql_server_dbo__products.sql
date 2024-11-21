WITH src_products AS (
    SELECT * 
    FROM {{ source('sql_server_dbo', 'products') }}
    ),
renamed_casted AS (
    SELECT
        product_id,
        name AS product_desc,
        price AS dollar_price,
        inventory,
        CASE
            WHEN inventory <= 0 THEN false
            ELSE true
        END AS stock 
    FROM src_products
    )

SELECT * FROM renamed_casted