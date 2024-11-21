WITH src_addresses AS (
    SELECT * 
    FROM {{ source('sql_server_dbo', 'addresses') }}
    ),
renamed_casted AS (
    SELECT DISTINCT
        zipcode AS zipcode_desc,
        {{ dbt_utils.generate_surrogate_key(['zipcode']) }} AS zipcode_id
    FROM src_addresses
    )

SELECT * FROM renamed_casted