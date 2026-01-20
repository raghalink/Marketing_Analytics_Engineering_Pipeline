-- Load data from staged parquet file into RAW.CRITEO_IMPRESSIONS table
copy into RAW.CRITEO_IMPRESSIONS
from @CRITEO_STAGE/criteo_sample_200k.parquet
file_format = (type = parquet)
match_by_column_name = case_insensitive;