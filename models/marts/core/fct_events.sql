{{ config(
    unique_key = 'event_id'
    ) 
}}
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
            created_at_utc,
            load_date_utc
        FROM stg_events
        {% if is_incremental() %}

            WHERE load_date_utc > (select max(load_date_utc) from {{ this }})

        {% endif %}
    )

SELECT * FROM events