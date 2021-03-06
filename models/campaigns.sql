{{ config(
    materialized='incremental',
    transient = false,
    alias='campaigns'
)
}}

select
    value::varchar as value,
    value_percent::number as value_percent,
    title::varchar as title,
    stats_url::varchar as stats_url,
    url::varchar as url,
    _fivetran_synced::timestamp_tz as record_loaded_at
from {{ source('clicky_sources', 'campaigns') }}
{{ do_incremental() }}