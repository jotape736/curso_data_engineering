WITH src_addresses AS (
    SELECT * 
    FROM {{ source('sql_server_dbo', 'addresses') }}
),

renamed_casted AS (
    SELECT
        address_id::VARCHAR(40) AS address_id,
        address::VARCHAR(50) AS address_desc,
        _fivetran_synced AS load_date
    FROM src_addresses
)

SELECT * FROM renamed_casted

