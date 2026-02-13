{{ config(materialized='view') }}

select
    order_id,
    customer_id,
    order_status,
    order_purchase_timestamp,
    cast(order_purchase_timestamp as date) as order_date,
    order_approved_at,
    order_delivered_timestamp,
    order_estimated_delivery_date
from {{ source('raw', 'shopify_orders') }}


