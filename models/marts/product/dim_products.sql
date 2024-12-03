{{ config(
    unique_key = 'product_id_id'
    ) 
}}

WITH stg_products AS (
    SELECT * 
    FROM {{ ref('stg_sql_server_dbo__products') }}
{% if is_incremental() %}

    WHERE load_date_utc > (select max(load_date_utc) from {{ this }})

{% endif %}
    ),

products AS (
    SELECT
        product_id,
        product_desc,
        price_usd,
        inventory,
        stock,
        load_date_utc
    FROM stg_products
    )

SELECT * FROM products


