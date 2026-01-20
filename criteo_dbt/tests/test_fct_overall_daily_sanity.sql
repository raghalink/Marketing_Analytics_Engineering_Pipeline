-- check if daily rows violates basic funnel logic.

select 
    event_day_bucket,
    impressions,
    clicks,
    conversions,
    attributed_conversions,
from {{ ref('fct_overall_daily') }}
where
clicks > impressions    
or conversions > impressions    
or attributed_conversions > conversions
