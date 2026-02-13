{{ config(materialized='table') }}

select
    transaction_id,
    product_id,
    store_id,
    quantity_sold as quantity,
    quantity_sold * unit_price as total_revenue,
    sale_date,
    'walmart' as sales_channel
from {{ ref('stg_walmart_sales') }}

