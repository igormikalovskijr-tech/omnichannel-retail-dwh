{{ config(materialized='table') }}

with base as (

    select * 
    from {{ ref('int_customer_channel_usage') }}

)

select
    case
        when channels_used = 1 then 'Single Channel'
        when channels_used >= 2 then 'Omnichannel'
        else 'Other'
    end as customer_type,
    count(*) as total_customers
from base
group by customer_type
