{% macro high_diff_low(high_price, low_price, scale=2) %}
    ({{ low_price }} - {{ high_price }})::decimal(16, {{ scale }})
{% endmacro %}
