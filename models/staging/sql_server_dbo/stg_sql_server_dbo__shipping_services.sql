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
        NULLIF(shipping_service,'') AS shipping_desc,
        NULLIF(shipping_service,'') AS shipping_service_id
    FROM src_orders
    )

SELECT DISTINCT
    shipping_desc,
    {{ dbt_utils.generate_surrogate_key(['shipping_service_id']) }} AS shipping_service_id
    FROM renamed_casted

