{{ config(materialized='view') }}

select
    customer_id,
    customer_zip_code_prefix,
    customer_city,
    customer_state
from {{ source('raw', 'shopify_customers') }}

