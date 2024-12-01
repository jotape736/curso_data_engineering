WITH src_budget AS (
    SELECT * 
    FROM {{ source('google_sheets', 'budget') }}
    ),

renamed_casted AS (
    SELECT
        {{dbt_utils.generate_surrogate_key(['product_id','quantity','month'])}} AS budget_id
        , product_id::VARCHAR(40) AS product_id
        , quantity::int AS quantity
        , month(month) AS month
        , year(month) AS year
        , CONVERT_TIMEZONE('UTC', _fivetran_synced) AS load_date_utc
    FROM src_budget
    )

SELECT * FROM renamed_casted