{{ config(materialized='table') }}

with sales as (
    select * 
    from {{ ref('fct_sales_unified') }}
),

products as (
    select * 
    from {{ ref('dim_product') }}
),

dates as (
    select * 
    from {{ ref('dim_date') }}
),

stores as (
    select * 
    from {{ ref('dim_store') }}
)

select
    s.transaction_id,
    s.product_id,
    p.product_category,
    s.store_id,
    st.store_location,
    s.quantity,
    s.total_revenue,
    s.sale_date,

    -- Date enrichments
    d.year,
    d.month,
    d.day,
    d.day_name,
    d.quarter,
    d.season,

    s.sales_channel

from sales s

left join products p
    on s.product_id = p.product_id

left join dates d
    on s.sale_date = d.date_day

left join stores st
    on s.store_id = st.store_id

