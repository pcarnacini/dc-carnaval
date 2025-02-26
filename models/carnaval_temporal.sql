with base as (
    select
        ano,
        cast(pontuacao_escola as float) as pontuacao
    from {{ ref('stg_carnaval') }}
)

select
    ano,
    count(*) as total_escolas,
    avg(pontuacao) as media_pontuacao,
    max(pontuacao) as max_pontuacao,
    min(pontuacao) as min_pontuacao
from base
group by ano
order by ano
