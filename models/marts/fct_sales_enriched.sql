{{ config(materialized='table') }}

with sales as (
    select *
    from {{ ref('int_sales_unified') }}
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
),

customers as (
    select *
    from {{ ref('dim_customer') }}
)

select
    -- Keys
    s.transaction_id,
    s.product_id,
    s.customer_id,
    s.store_id,

    -- Product
    p.product_category,

    -- Store
    st.store_location,

    -- Customer
    c.customer_city,
    c.customer_state,

    -- Metrics
    s.quantity,
    s.total_revenue,

    -- Date
    s.sale_date,
    d.year,
    d.month,
    d.quarter,
    d.day,
    d.day_name,
    d.season,

    -- Channel
    s.sales_channel

from sales s

left join products p
    on s.product_id = p.product_id

left join stores st
    on s.store_id = st.store_id

left join customers c
    on s.customer_id = c.customer_id

left join dates d
    on s.sale_date = d.date_day

