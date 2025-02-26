select
    ano,
    count(distinct nome_escola) as total_escolas,
    avg(cast(pontuacao_escola as float)) as media_pontuacao,
    sum(case when posicao = 1 then 1 else 0 end) as total_campeoes
from {{ ref('stg_carnaval') }}
group by ano
order by ano
