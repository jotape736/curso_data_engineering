WITH src_addresses AS (
    SELECT * 
    FROM {{ source('sql_server_dbo', 'addresses') }}
    ),
renamed_casted AS (
    SELECT DISTINCT
        country::VARCHAR(50) AS country_desc,
        {{ dbt_utils.generate_surrogate_key(['country']) }} AS country_id
    FROM src_addresses
    )

SELECT * FROM renamed_casted