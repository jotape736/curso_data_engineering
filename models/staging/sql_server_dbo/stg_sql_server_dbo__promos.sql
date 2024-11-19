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
        CONVERT_TIMEZONE('UTC', 'Europe/Paris', CURRENT_TIMESTAMP()) AS _fivetran_synced,
        NULL AS _fivetran_deleted
    UNION ALL
    SELECT
        md5(promo_id) AS promo_id,
        INITCAP(promo_id) AS promo_desc,
        -- CAST(discount / 10 AS FLOAT) AS discount, por qué con esto en snowflake se ve como un entero?
        discount,
        status,
        CONVERT_TIMEZONE('UTC', 'Europe/Paris',  CAST(_fivetran_synced AS TIMESTAMP_NTZ)) AS _fivetran_synced, -- Pero esto no estaba ya en TIMESTAMP_TZ(9)??
        _fivetran_deleted
    FROM src_promos
)

SELECT * FROM renamed_casted
