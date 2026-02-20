{{ config(materialized='table') }}

with date_spine as (

    select distinct sale_date
    from {{ ref('int_sales_unified') }}

)

select
    sale_date as date_day,
    extract(year from sale_date) as year,
    extract(month from sale_date) as month,
    extract(day from sale_date) as day,
    extract(quarter from sale_date) as quarter,
    dayname(sale_date) as day_name,
    case 
        when extract(month from sale_date) in (12,1,2) then 'Winter'
        when extract(month from sale_date) in (3,4,5) then 'Spring'
        when extract(month from sale_date) in (6,7,8) then 'Summer'
        else 'Fall'
    end as season
from date_spine

