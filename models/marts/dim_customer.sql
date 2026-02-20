{{ config(materialized='table') }}

with shopify_customers as (

    select
        customer_id,
        customer_city,
        customer_state
    from {{ ref('stg_shopify_customers') }}
    where customer_id is not null

),

walmart_customers as (

    select distinct
        customer_id,
        null as customer_city,
        null as customer_state
    from {{ ref('stg_walmart_sales') }}
    where customer_id is not null

),

all_customers as (

    select * from shopify_customers
    union all
    select * from walmart_customers

)

select
    customer_id,
    min(customer_city)  as customer_city,
    min(customer_state) as customer_state
from all_customers
group by customer_id

