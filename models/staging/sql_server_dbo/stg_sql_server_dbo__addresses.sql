WITH src_addresses AS (
    SELECT * 
    FROM {{ source('sql_server_dbo', 'addresses') }}
),

renamed_casted AS (
    SELECT
        address_id,
        address,
        zipcode AS zipcode_desc,
        md5(zipcode) AS zipcode_id,
        country AS country_desc,
        md5(country) AS country_id,
        state AS state_desc,
        md5(state) AS state_id,
        _fivetran_synced AS load_date
    FROM src_addresses
)

SELECT * FROM renamed_casted

