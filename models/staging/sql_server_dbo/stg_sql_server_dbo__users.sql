WITH src_users AS (
    SELECT * 
    FROM {{ source('sql_server_dbo', 'users') }}
    ),
renamed_casted AS (
    SELECT
        user_id::VARCHAR(40) AS user_id,
        address_id::VARCHAR(40) AS address_id,
        last_name::VARCHAR(20) AS last_name,
        CONVERT_TIMEZONE('UTC', created_at) AS created_at_utc,
        phone_number::VARCHAR(12) AS phone_number,
        first_name::VARCHAR(20) AS first_name,
        email::VARCHAR(50) AS email,
        CONVERT_TIMEZONE('UTC', _fivetran_synced) AS load_date_utc
    FROM src_users
    )

SELECT * FROM renamed_casted