SELECT
  id,
  stock_symbol,
  CAST(stock_date AS DATE) AS stock_date,
  CAST(open_price AS NUMBER(38, 2)) AS open_price,
  CAST(high_price AS NUMBER(38, 2)) AS high_price,
  CAST(low_price AS NUMBER(38, 2)) AS low_price,
  CAST(close_price AS NUMBER(38, 2)) AS close_price,
  CAST(daily_volume AS NUMBER(38, 0)) AS daily_volume,
  close_diff_open,
  high_diff_low
FROM
  {{ ref('int_pqsd') }}
ORDER BY
  stock_date DESC
