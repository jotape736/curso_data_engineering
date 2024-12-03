{{ config(
    unique_key = 'budget_id'
    ) 
}}

WITH stg_budget AS (
    SELECT * 
    FROM {{ ref('stg_google_sheets__budget') }}
    {% if is_incremental() %}

        WHERE load_date_utc > (select max(load_date_utc) from {{ this }})

    {% endif %}
    ),

    budget AS (
        SELECT
            budget_id
            ,product_id
            ,quantity
            ,month
            ,year
            ,load_date_utc
        FROM stg_budget
    )

SELECT * FROM budget

