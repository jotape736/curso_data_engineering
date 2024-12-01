WITH src_orders AS (
    SELECT * 
    FROM {{ source('sql_server_dbo', 'orders') }}
    ),

renamed_casted AS (
    SELECT
        order_id::VARCHAR(40) AS order_id,
        {{ dbt_utils.generate_surrogate_key(["NULLIF(shipping_service,'')"]) }} AS shipping_service_id,
        COALESCE(NULLIF(shipping_service,''), 'not_yet_assigned') AS shipping_service_desc,
        shipping_cost AS shipping_cost_usd,
        address_id,
        CONVERT_TIMEZONE('UTC', created_at) AS created_at_utc,
        {{ dbt_utils.generate_surrogate_key(["NULLIF(promo_id,'')"]) }} AS promo_id,
        CONVERT_TIMEZONE('UTC', estimated_delivery_at) AS estimated_delivery_at_utc,
        order_cost AS order_cost_usd,
        user_id,
        order_total AS order_total_usd,
        CONVERT_TIMEZONE('UTC', delivered_at) AS delivered_at_utc,
        NULLIF(tracking_id,'') AS tracking_id,
        {{ dbt_utils.generate_surrogate_key(['status']) }} AS status_id,
        status::VARCHAR(15) AS status_desc,
        CONVERT_TIMEZONE('UTC', _fivetran_synced) AS load_date_utc,
        DATEDIFF(day, created_at_utc, delivered_at_utc) AS days_to_deliver
    FROM src_orders
    )

SELECT
    *
FROM renamed_casted

