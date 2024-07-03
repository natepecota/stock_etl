SELECT
  {{
    dbt_utils.generate_surrogate_key([
        'symbol',
        'stock_date'
      ])
  }} as id,
  symbol as stock_symbol,
  stock_date,
  open as open_price,
  high as high_price,
  low as low_price,
  close as close_price,
  volume as daily_volume
FROM
  {{ source('pqsd', 'stock_data_parquet') }}
