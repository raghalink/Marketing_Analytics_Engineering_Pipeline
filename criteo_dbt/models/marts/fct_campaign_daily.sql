{{ 
  config(
    materialized='incremental',
    incremental_strategy='delete+insert',
    unique_key=['event_day_bucket','campaign_id']
  ) }}

with base as  (
    select * from {{ ref('stg_criteo_impressions')}}
    
     {% if is_incremental() %}
    where floor(event_ts/86400) >= (
      select coalesce(max(event_day_bucket), 0) - {{ var('incremental_backfill_days', 3) }}
      from {{ this }}
    )
  {% endif %}
    )

select
    floor(event_ts/86400)                                       as event_day_bucket,
    campaign_id,
    count(*)                                                    as impressions,
    count_if(is_click)                                          as clicks,
    count_if(is_conversion)                                     as conversions,
    sum(cost)                                                   as spend,
    count_if(is_attributed)                                     as attributed_conversions,
    sum(case when is_attributed then cpo else 0 end)            as attributed_value
from base
group by event_day_bucket, campaign_id
