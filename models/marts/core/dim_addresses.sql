{{ config(
    unique_key = 'address_id'
    ) 
}}
WITH stg_addresses AS (
    SELECT * 
    FROM {{ ref('stg_sql_server_dbo__addresses') }}

    {% if is_incremental() %}

        WHERE load_date_utc > (select max(load_date_utc) from {{ this }})

    {% endif %}
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