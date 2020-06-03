{{ config(
    materialized='incremental',
    transient = false,
    alias='vistors_list'
)
}}

select
    uid::number as uid,
    session_id::number as session_id,
    time::timestamp_ntz as visit_date_time,
    time_pretty::varchar as time_pretty,
    time_total::number as time_total,
    ip_address::varchar as ip_address,
    actions::number as actions,
    total_visits::number as total_visits,
    landing_page::varchar as landing_page,
    web_browser::varchar as web_browser,
    operating_system::varchar as operating_system,
    screen_resolution::varchar as screen_resolution,
    javascript::varchar as javascript,
    language::varchar as language,
    referrer_url::varchar as referrer_url,
    referrer_domain::varchar as referrer_domain,
    referrer_search::varchar as referrer_search,
    referrer_type::varchar as referrer_type,
    geolocation::varchar as geolocation,
    country_code::varchar as country_code,
    latitude::number as latitude,
    longitude::number as longitude,
    organization::varchar as organization,
    stats_url::varchar as stats_url,
    hostname::varchar as hostname,
    _fivetran_synced::timestamp_tz as record_loaded_at
from {{ source('clicky_sources', 'visitors_list') }}
{{ do_incremental() }}