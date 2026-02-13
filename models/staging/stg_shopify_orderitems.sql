{{ config(materialized='view') }}

select
    order_id,
    product_id,
    seller_id,
    shipping_charges,
    price
from {{ source('raw', 'shopify_order_items') }}

