{{ config(
    unique_key = 'promo_id'
    ) 
}}

WITH stg_promos AS (
    SELECT * 
    FROM {{ ref('stg_sql_server_dbo__promos') }}
    {% if is_incremental() %}

        WHERE load_date_utc > (select max(load_date_utc) from {{ this }})

    {% endif %}
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