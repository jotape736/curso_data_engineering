WITH src_promos AS (
    SELECT * 
    FROM {{ source('sql_server_dbo', 'promos') }}
),

renamed_casted AS (
    SELECT
        md5('No-promo') AS promo_id,
        'No-promo' AS promo_desc,
        0 / 10 AS discount,
        'inactive' AS status,
        --CONVERT_TIMEZONE('UTC', 'Europe/Paris', CURRENT_TIMESTAMP()) AS load_date,
        null as load_date,
        NULL AS _fivetran_deleted
    UNION ALL
    SELECT
        {{ dbt_utils.generate_surrogate_key(['promo_id']) }} AS promo_id,
        INITCAP(promo_id) AS promo_desc,
        -- CAST(discount / 10 AS FLOAT) AS discount, por qué con esto en snowflake se ve como un entero?
        discount,
        status,
        _fivetran_synced AS load_date,
        _fivetran_deleted
    FROM src_promos
)

SELECT
    promo_id,
    promo_desc,
    discount,
    status,
    load_date
FROM renamed_casted
