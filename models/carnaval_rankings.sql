with base as (
    select
        ano,
        grupo,
        associacao,
        nome_escola,
        cast(pontuacao_escola as float) as pontuacao
    from {{ ref('stg_carnaval') }}
),
rankings as (
    select
        ano,
        grupo,
        associacao,
        nome_escola,
        pontuacao,
        rank() over(partition by ano order by pontuacao desc) as rank_ano
    from base
)

select *
from rankings
order by ano, rank_ano
