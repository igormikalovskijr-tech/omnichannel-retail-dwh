{{ config(materialized='table') }}

with walmart as (

    select 
        sale_date,
        count(*) as walmart_records,
        sum(quantity) as walmart_units,
        sum(total_revenue) as walmart_revenue
    from {{ ref('fct_sales_walmart') }}
    group by 1

),

shopify as (

    select 
        sale_date,
        count(*) as shopify_records,
        sum(quantity) as shopify_units,
        sum(total_revenue) as shopify_revenue
    from {{ ref('fct_sales_shopify') }}
    group by 1

),

unified as (

    select 
        sale_date,
        count(*) as unified_records,
        sum(quantity) as unified_units,
        sum(total_revenue) as unified_revenue
    from {{ ref('int_sales_unified') }}
    group by 1

)

select
    coalesce(w.sale_date, s.sale_date, u.sale_date) as sale_date,

    walmart_records,
    shopify_records,
    unified_records,

    walmart_units,
    shopify_units,
    unified_units,

    walmart_revenue,
    shopify_revenue,
    unified_revenue,

    (coalesce(walmart_records,0) + coalesce(shopify_records,0)) 
        - coalesce(unified_records,0) as record_difference

from walmart w
full outer join shopify s using (sale_date)
full outer join unified u using (sale_date)

