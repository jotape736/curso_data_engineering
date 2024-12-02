WITH stg_budget AS (
    SELECT * 
    FROM {{ ref('stg_google_sheets__budget') }}
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

{% if is_incremental() %}

  where load_date_utc > (select max(load_date_utc) from {{ this }})

{% endif %}