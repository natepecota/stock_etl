SELECT
  id,
  stock_symbol,
  stock_date,
  open_price,
  high_price,
  low_price,
  close_price,
  daily_volume,
  {{ close_diff_open('close_price', 'open_price') }} as close_diff_open,
  {{ high_diff_low('high_price', 'low_price') }} as high_diff_low
FROM
  {{ ref('stg_pqsd') }}
ORDER BY
  stock_date DESC
