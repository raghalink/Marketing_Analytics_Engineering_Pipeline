create or replace table RAW.CRITEO_IMPRESSIONS (
timestamp number,
uid number,
campaign number,
conversion boolean,
conversion_timestamp number,
conversion_id number,
attribution boolean,
click boolean,
cost float,
cpo float
);
