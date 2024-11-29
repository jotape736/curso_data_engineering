WITH src_products AS (
    SELECT * 
    FROM {{ source('sql_server_dbo', 'products') }}
    ),
renamed_casted AS (
    SELECT
        product_id::VARCHAR(50) AS product_id,
        name::VARCHAR(30) AS product_desc,
        price AS price_usd,
        inventory::int AS inventory,
        CASE
            WHEN inventory <= 0 THEN false
            ELSE true
        END AS stock,
        CONVERT_TIMEZONE('UTC', _fivetran_synced) AS load_date_utc 
    FROM src_products
    )

SELECT * FROM renamed_casted