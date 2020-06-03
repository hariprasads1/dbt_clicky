{{ config(
    materialized='incremental',
    transient = false,
    alias='actions_list'
)
}}

select
    time::timestamp_tz as action_time,
    action_url::varchar as action_url,
    uid::number as uid,
    action_type::varchar as action_type,
    action_title::varchar as action_title,
    time_pretty::varchar as time_pretty,
    session_id::number as session_id,
    stats_url::varchar as stats_url,
    ip_address::varchar as ip_address,
    referrer_domain::varchar as referrer_domain,
    referrer_search::varchar as referrer_search,
    referrer_url::varchar as referrer_url,
    _fivetran_synced::timestamp_tz as record_loaded_at
from {{ source('clicky_sources', 'actions_list') }}
{{ do_incremental() }}