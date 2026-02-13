{{ config(materialized='table') }}

select
    customer_id,
    min(customer_city)  as customer_city,
    min(customer_state) as customer_state
from {{ ref('stg_shopify_customers') }}
where customer_id is not null
group by customer_id


