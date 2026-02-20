{{ config(materialized='table') }}

select
    sale_date,
    product_id,
    sum(quantity) as total_units,
    sum(total_revenue) as total_revenue
from {{ ref('int_sales_unified') }}
group by 1,2


