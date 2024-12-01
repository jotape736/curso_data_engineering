WITH stg_addresses AS (
    SELECT * 
    FROM {{ ref('stg_sql_server_dbo__addresses') }}
    ),

addresses AS (
    SELECT
        address_id,
        address_desc,
        zipcode,
        country,
        state,
        load_date_utc
    FROM stg_addresses
    )

SELECT * FROM addresses