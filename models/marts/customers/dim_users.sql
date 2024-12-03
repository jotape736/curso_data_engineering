{{ config(
    unique_key = 'user_id'
    ) 
}}

WITH stg_users AS (
    SELECT * 
    FROM {{ ref('stg_sql_server_dbo__users') }}
{% if is_incremental() %}

    WHERE load_date_utc > (select max(load_date_utc) from {{ this }})

{% endif %}
    ),

users AS (
    SELECT
        user_id
        , first_name
        , last_name
        , email
        , phone_number
        , created_at_utc
        , address_id
        , load_date_utc
    FROM stg_users
    )

SELECT * FROM users