select max(floor(TIMESTAMP/86400)) as max_ts,
(select max(event_day_bucket)from marketing_db.analytics.fct_overall_daily) as mart_max_day 
from marketing_db.raw.criteo_impressions;
