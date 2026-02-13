{{ config(materialized='view') }}

select
    transaction_id,
    customer_id,
    product_id,
    product_name,
    category,
    quantity_sold,
    unit_price,
    quantity_sold * unit_price as revenue,
    cast(transaction_date as date) as sale_date,
    transaction_date,
    store_id,
    store_location,
    customer_age,
    customer_gender,
    customer_income,
    customer_loyalty_level,
    payment_method
from {{ source('raw', 'walmart_sales') }}

