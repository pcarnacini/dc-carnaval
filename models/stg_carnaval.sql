with carnaval_data as (
    {% for ano in range(1984, 2025) %}
    select 
        {% set columns_query %}
            SELECT column_name
            FROM information_schema.columns
            WHERE table_schema = 'public' 
            AND table_name = 'resultado_{{ ano }}'
        {% endset %}
        
        {% set columns = run_query(columns_query) %}
        
        {% set select_columns = [] %}
        {% for column in columns %}
            {% if column.column_name != 'escola_id' %}
                {% do select_columns.append(column.column_name) %}
            {% endif %}
        {% endfor %}
        
        {{ select_columns | join(', ') }},
        '{{ ano }}' as ano_carnaval
    from {{ source('public', 'resultado_' ~ ano) }} 
    {% if not loop.last %}union all{% endif %}
    {% endfor %}
)

select * from carnaval_data
