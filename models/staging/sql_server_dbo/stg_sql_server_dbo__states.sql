WITH src_addresses AS (
    SELECT * 
    FROM {{ source('sql_server_dbo', 'addresses') }}
    ),
renamed_casted AS (
    SELECT DISTINCT
        state AS desc_state,
        {{ dbt_utils.generate_surrogate_key(['state']) }} AS state_id
    FROM src_addresses
    )

SELECT * FROM renamed_casted