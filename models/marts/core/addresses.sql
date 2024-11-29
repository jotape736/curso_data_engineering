WITH stg_users AS (
    SELECT * 
    FROM {{ ref('stg_sql_server_dbo__addresses') }}
    ),

renamed_casted AS (
    SELECT
        user_id
        , first_name
        , last_name
        , email
        , phone_number
        , created_at
        , address_id
        , load_date
    FROM stg_users
    )

SELECT * FROM renamed_casted