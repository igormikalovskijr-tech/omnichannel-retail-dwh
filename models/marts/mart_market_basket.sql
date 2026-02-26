{{ config(materialized='table') }}

select
    p1.product_category as product_1_category,
    p2.product_category as product_2_category,
    ipp.times_bought_together
from {{ ref('int_product_pairs') }} ipp
left join {{ ref('dim_product') }} p1
    on ipp.product_1 = p1.product_id
left join {{ ref('dim_product') }} p2
    on ipp.product_2 = p2.product_id
