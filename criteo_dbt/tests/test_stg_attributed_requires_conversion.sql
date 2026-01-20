select * from {{ ref('stg_criteo_impressions') }} 
where is_attributed = true 
and is_conversion = false