CREATE STAGE IF NOT EXISTS stock_db.external_staging.parquetstage2;

CREATE OR REPLACE STAGE stock_db.external_staging.parquetstage2
    url = 's3://<path/to_parquet_file/location/in_s3'
    credentials = (AWS_KEY_ID = '<AWS_KEY_ID>' AWS_SECRET_KEY = '<AWS_SECRET_KEY>')
    file_format= stock_db.file_formats.parquet_format;

LIST @stock_db.external_staging.parquetstage2;

SELECT * FROM @stock_db.external_staging.parquetstage2;

SELECT
    $1: "Symbol",
    $1: "Name",
    $1: "Description",
    $1: "Exchange",
    $1: "Sector",
    $1: "Industry",
    $1: "MarketCapitalization",
    $1: "AnalystTargetPrice",
    $1: "52WeekHigh",
    $1: "52WeekLow",
    $1: "50DayMovingAverage",
    $1: "200DayMovingAverage"
FROM
    @stock_db.external_staging.parquetstage2;

SELECT COUNT(*) FROM @stock_db.external_staging.parquetstage2;

CREATE TABLE IF NOT EXISTS stock_data_desc (
    symbol VARCHAR,
    name VARCHAR,
    description VARCHAR,
    exchange VARCHAR,
    sector VARCHAR,
    industry VARCHAR,
    market_capitalization NUMBER(38, 2),
    analyst_target_price NUMBER(38, 2),
    fifty_two_week_high NUMBER(38, 2),
    fifty_two_week_low NUMBER(38, 2),
    fifty_day_moving_average NUMBER(38, 2),
    two_hundred_day_moving_average NUMBER(38, 2)
);

COPY INTO stock_db.public.stock_data_desc
FROM (
    SELECT
    $1: "Symbol",
    $1: "Name",
    $1: "Description",
    $1: "Exchange",
    $1: "Sector",
    $1: "Industry",
    $1: "MarketCapitalization",
    $1: "AnalystTargetPrice",
    $1: "52WeekHigh",
    $1: "52WeekLow",
    $1: "50DayMovingAverage",
    $1: "200DayMovingAverage"
FROM
    @stock_db.external_staging.parquetstage2
);

SELECT * FROM stock_db.public.stock_data_desc;
