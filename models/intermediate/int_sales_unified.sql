{{ config(materialized='table') }}

select
    transaction_id,
    customer_id,
    product_id,
    store_id,
    quantity,
    total_revenue,
    sale_date,
    sales_channel
from {{ ref('fct_sales_walmart') }}

union all

select
    transaction_id,
    customer_id,
    product_id,
    store_id,
    quantity,
    total_revenue,
    sale_date,
    sales_channel
from {{ ref('fct_sales_shopify') }}

