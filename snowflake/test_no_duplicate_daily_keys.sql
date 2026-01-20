-- check for duplicated after incremental should not return rows
select event_day_bucket from marketing_db.analytics.fct_overall_daily
group by 1
having count(*) > 1;

-- no duplicates test for fct_campaign_daily
select event_day_bucket,campaign_id
from marketing_db.analytics.fct_campaign_daily
group by 1,2
having count(*) > 1;