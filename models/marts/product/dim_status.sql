{{ config(
    unique_key = 'status_id'
    ) 
}}

WITH stg_orders AS (
    SELECT * 
    FROM {{ ref('stg_sql_server_dbo__orders') }}
{% if is_incremental() %}

    WHERE load_date_utc > (select max(load_date_utc) from {{ this }})

{% endif %}
    ),

status AS (
    SELECT
        status_id,
        status_desc,
        load_date_utc
    FROM stg_orders
    )

SELECT DISTINCT * FROM status