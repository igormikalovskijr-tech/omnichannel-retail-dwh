{{ config(materialized='table') }}

with order_items as (

    select
        order_id,
        product_id,
        1 as quantity,
        price + shipping_charges as revenue
    from {{ ref('stg_shopify_orderitems') }}

),

orders as (

    select
        order_id,
        order_purchase_timestamp as sale_date
    from {{ ref('stg_shopify_orders') }}

)

select
    oi.order_id as transaction_id,
    oi.product_id,
    null as store_id,
    oi.quantity,
    oi.revenue as total_revenue,
    o.sale_date,
    'shopify' as sales_channel
from order_items oi
join orders o
    on oi.order_id = o.order_id

  
