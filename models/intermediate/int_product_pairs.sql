{{ config(materialized='table') }}

with customer_products as (

    select distinct
        customer_id,
        product_id
    from {{ ref('fct_sales_enriched') }}
    where customer_id is not null

),

product_pairs as (

    select
        cp1.product_id as product_1,
        cp2.product_id as product_2,
        count(distinct cp1.customer_id) as times_bought_together
    from customer_products cp1
    join customer_products cp2
        on cp1.customer_id = cp2.customer_id
        and cp1.product_id < cp2.product_id
    group by 1,2

)

select *
from product_pairs
where times_bought_together >= 2
