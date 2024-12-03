SELECT
   session_id,
   user_data.user_id,
   user_data.first_name,
   user_data.last_name,
   user_data.email,
   MIN(events.created_at_utc) AS first_event_time_utc,
   MAX(events.created_at_utc) AS last_event_time_utc,
   DATEDIFF(min, first_event_time_utc, last_event_time_utc) AS session_length_minutes,
   SUM(CASE
    WHEN event_type = 'page_view' THEN 1
    ELSE 0
   END) AS page_view,
   SUM(CASE
    WHEN event_type = 'add_to_cart' THEN 1
    ELSE 0
   END) AS add_to_cart,
   SUM(CASE
    WHEN event_type = 'checkout' THEN 1
    ELSE 0
   END) AS checkout,
   SUM(CASE
    WHEN event_type = 'package_shipped' THEN 1
    ELSE 0
   END) AS package_shipped
FROM {{ ref('fct_events') }} events
INNER JOIN {{ ref('dim_user_data') }} user_data
    ON events.user_id = user_data.user_id
GROUP BY session_id,
        user_data.user_id,
        user_data.first_name,
        user_data.last_name,
        user_data.email