WITH src_promos AS (
    SELECT * 
    FROM {{ source('sql_server_dbo', 'promos') }}
),

renamed_casted AS (
    SELECT
        {{ dbt_utils.generate_surrogate_key(['null']) }} AS promo_id,
        'No-promo' AS promo_desc,
        0 / 100 AS discount_percentaje,
        'inactive' AS status,
        null as load_date,
    UNION ALL
    SELECT
        {{ dbt_utils.generate_surrogate_key(['promo_id']) }} AS promo_id,
        promo_id::VARCHAR(20) AS promo_desc,
        discount / 100 AS discount_percentaje,
        status::VARCHAR(20) AS status,
        CONVERT_TIMEZONE('UTC', _fivetran_synced) AS load_date,
    FROM src_promos
)

SELECT
   *
FROM renamed_casted
