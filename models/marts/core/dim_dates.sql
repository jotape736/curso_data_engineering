WITH src_fechas AS (
    SELECT * 
    FROM {{ ref('dates') }}
    ),

renamed AS (
    SELECT
        fecha_forecast AS date,
        id_date,
        anio AS year,
        mes AS month,
        desc_mes AS month_desc,
        id_anio_mes AS id_year_month,
        dia_previo AS previous_day,
        anio_semana_dia AS year_week_day,
        semana AS week
    FROM src_fechas
    )

SELECT * FROM renamed