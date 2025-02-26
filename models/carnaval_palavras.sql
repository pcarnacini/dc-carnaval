with enredos as (
    select
        ano,
        lower(enredo_escola) as enredo
    from {{ ref('stg_carnaval') }}
),
tokens as (
    select
        ano,
        unnest(string_to_array(enredo, ' ')) as palavra
    from enredos
)
select
    palavra,
    count(*) as frequencia
from tokens
where palavra <> ''
group by palavra
order by frequencia desc
