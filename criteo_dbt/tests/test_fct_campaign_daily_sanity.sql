-- check if daily campaign row violates basic funnle logic. 
select 
    event_day_bucket,
    campaign_id,
    impressions,
    clicks,
    conversions,
    attributed_conversions
from {{ ref('fct_campaign_daily') }}
where
clicks > impressions
or conversions > impressions    
or attributed_conversions > conversions