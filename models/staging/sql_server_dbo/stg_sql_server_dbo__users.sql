WITH src_users AS (
    SELECT * 
    FROM {{ source('sql_server_dbo', 'users') }}
    ),
renamed_casted AS (
    SELECT
        user_id,
        address_id,
        last_name,
        CONVERT_TIMEZONE('UTC', created_at) AS created_at,
        phone_number,
        first_name,
        email,
        CONVERT_TIMEZONE('UTC', _fivetran_synced) AS load_date
    FROM src_users
    )

SELECT * FROM renamed_casted