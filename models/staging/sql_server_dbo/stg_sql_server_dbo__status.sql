{{
  config(
    materialized='view'
  )
}}

WITH src_orders AS (
    SELECT * 
    FROM {{ source('sql_server_dbo', 'orders') }}
    ),
renamed_casted AS (
    SELECT
        {{dbt_utils.generate_surrogate_key(['status'])}} AS status_id,
        status::VARCHAR(20) AS status_desc
    FROM src_orders
    )

SELECT DISTINCT
    *
FROM renamed_casted