{{ config(materialized='table') }}

with walmart_products as (

    select distinct
        product_id,
        category as product_category
    from {{ ref('stg_walmart_sales') }}

),

shopify_products as (

    select distinct
        product_id,
        product_category_name as product_category
    from {{ ref('stg_shopify_products') }}

),

all_products as (

    select * from walmart_products
    union
    select * from shopify_products

)

select
    product_id,
    min(product_category) as product_category
from all_products
group by product_id


