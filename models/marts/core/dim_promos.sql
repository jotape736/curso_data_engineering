WITH stg_promos AS (
    SELECT * 
    FROM {{ ref('stg_sql_server_dbo__promos') }}
    ),

promos AS (
    SELECT
        promo_id,
        promo_desc,
        discount,
        status,
        load_date_utc,
    FROM stg_promos
    )

SELECT * FROM promos