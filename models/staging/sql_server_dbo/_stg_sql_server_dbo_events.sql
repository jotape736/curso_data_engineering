WITH src_events AS (
    SELECT * 
    FROM {{ source('sql_server_dbo', 'events') }}
),

renamed_casted AS (
    SELECT
        event_id,
        page_url,
        {{dbt_utils.generate_surrogate_key(['event_type'])}} AS event_id,
        user_id,
        NULLIF(product_id,'') AS product_id,
        session_id,
        CONVERT_TIMEZONE('UTC',created_at) AS created_at,
        NULLIF(order_id,'') AS order_id,
        CONVERT_TIMEZONE('UTC',_fivetran_synced) AS created_at,
    FROM src_events
)

SELECT * FROM renamed_casted