WITH stg_orders AS (
    SELECT * 
    FROM {{ ref('stg_sql_server_dbo__orders') }}
    ),

status AS (
    SELECT
        status_id,
        status_desc
    FROM stg_orders
    )

SELECT DISTINCT * FROM status