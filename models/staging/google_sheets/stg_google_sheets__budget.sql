WITH src_budget AS (
    SELECT * 
    FROM {{ source('google_sheets', 'budget') }}
    ),

renamed_casted AS (
    SELECT
        {{dbt_utils.generate_surrogate_key(['product_id','quantity','month'])}} AS budget_id
        , product_id
        , quantity::int AS quantity
        , month(month) AS month
        , CONVERT_TIMEZONE('UTC', _fivetran_synced) AS load_date
    FROM src_budget
    )

SELECT * FROM renamed_casted