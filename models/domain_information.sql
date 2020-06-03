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
{{ do_incremental() }}