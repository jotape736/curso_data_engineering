WITH stg_users AS (
    SELECT * 
    FROM {{ ref('stg_sql_server_dbo__addresses') }}
    ),

renamed_casted AS (
    SELECT
        address_id,
        address_desc,
        zipcode,
        country,
        state,
        load_date_utc
    FROM stg_users
    )

SELECT * FROM renamed_casted