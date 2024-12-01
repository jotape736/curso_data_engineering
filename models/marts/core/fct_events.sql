WITH stg_events AS (
    SELECT * 
    FROM {{ ref('stg_sql_server_dbo__events') }}
    ),

    events AS (
        SELECT
            event_id,
            session_id,
            user_id,
            page_url,
            event_type_desc AS event_type,
            product_id,
            order_id,
            created_at_utc
        FROM stg_events
    )

SELECT * FROM events