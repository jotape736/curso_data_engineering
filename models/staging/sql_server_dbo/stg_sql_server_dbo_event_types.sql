WITH src_events AS (
    SELECT * 
    FROM {{ source('sql_server_dbo', 'events') }}
),

renamed_casted AS (
    SELECT DISTINCT
        {{dbt_utils.generate_surrogate_key(['event_type'])}} AS event_id,
        event_type AS event_desc
    FROM src_events
)

SELECT * FROM renamed_casted