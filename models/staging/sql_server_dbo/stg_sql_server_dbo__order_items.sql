WITH src_order_items AS (
    SELECT * 
    FROM {{ source('sql_server_dbo', 'order_items') }}
    ),

renamed_casted AS (
    SELECT
        order_id::VARCHAR(40) AS order_id,
        product_id,
        quantity::int AS quantity,
        CONVERT_TIMEZONE('UTC', _fivetran_synced) AS load_date_utc
    FROM src_order_items
    )

SELECT
    *
FROM renamed_casted

