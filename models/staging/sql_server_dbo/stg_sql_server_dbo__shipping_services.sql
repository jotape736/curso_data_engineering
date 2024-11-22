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
        {{ dbt_utils.generate_surrogate_key(["COALESCE(NULLIF(shipping_service, ''),'not_asigned_yet')"]) }} AS shipping_service_id,
        COALESCE(NULLIF(shipping_service, ''),'not_asigned_yet') AS shipping_desc
    FROM src_orders
    )

SELECT DISTINCT
    *
    FROM renamed_casted

