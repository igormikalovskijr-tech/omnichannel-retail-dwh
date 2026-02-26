{{ config(materialized='table') }}

select
    customer_id,
    count(distinct sales_channel) as channels_used
from {{ ref('fct_sales_enriched') }}
where customer_id is not null
group by customer_id
