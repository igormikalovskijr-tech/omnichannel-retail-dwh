{{ config(materialized='table') }}

WITH ranked AS (

    SELECT
        store_id,
        store_location,
        ROW_NUMBER() OVER (
            PARTITION BY store_id
            ORDER BY store_location
        ) AS rn
    FROM {{ ref('stg_walmart_sales') }}

)

SELECT
    store_id,
    store_location
FROM ranked
WHERE rn = 1

