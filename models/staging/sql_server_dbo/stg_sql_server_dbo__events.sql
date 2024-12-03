WITH src_events AS (
    SELECT * 
    FROM {{ source('sql_server_dbo', 'events') }}
    ),

    renamed_casted AS (
        SELECT
            event_id::VARCHAR(40) AS event_id,
            page_url::VARCHAR(150) AS page_url,
            {{dbt_utils.generate_surrogate_key(['event_type'])}} AS event_type_id,
            event_type::VARCHAR(20) AS event_type_desc,
            user_id::VARCHAR(40) AS user_id,
            NULLIF(product_id,'') AS product_id,
            session_id::VARCHAR(40) AS session_id,
            CONVERT_TIMEZONE('UTC',created_at) AS created_at_utc,
            NULLIF(order_id,'')::VARCHAR(40) AS order_id,
            CONVERT_TIMEZONE('UTC',_fivetran_synced) AS load_date_utc
        FROM src_events
    )

SELECT * FROM renamed_casted