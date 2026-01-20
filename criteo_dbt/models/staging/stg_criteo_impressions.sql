{{ config(materialized = 'view',tags = ['staging']) }}

with source AS (
    select
        *
    from
        {{ source('raw', 'criteo_impressions') }}
)

SELECT 
CAST(timestamp as NUMBER)               AS event_ts,
CAST(uid as NUMBER)                     AS user_id,
CAST(campaign as NUMBER)                AS campaign_id,
CAST(conversion as BOOLEAN)             AS is_conversion,
CAST(attribution as BOOLEAN)            AS is_attributed,
CAST(click as BOOLEAN)                  AS is_click,
CAST(cost AS FLOAT)                     AS cost,
CAST(cpo AS FLOAT)                      AS cpo,
CAST(conversion_timestamp as NUMBER)    AS conversion_event_ts,
CAST(conversion_id as NUMBER)           AS conversion_id
FROM source

