{{ config(
    materialized='incremental',
    transient = false,
    alias='domain_information'
)
}}

select
    domain::varchar as domain,
    name::varchar as organization,
    logo::varchar as logo_URL,
    _fivetran_synced::timestamp_tz as record_loaded_at
from {{ source('clicky_sources', 'domain_information') }}
{% if is_incremental() %}
    where record_loaded_at > (select max(record_loaded_at) from {{this}})
{% endif %}