
CREATE DATABASE IF NOT EXISTS stock_db;

CREATE SCHEMA IF NOT EXISTS file_formats;

CREATE OR REPLACE FILE FORMAT stock_db.file_formats.parquet_format
    TYPE = parquet;

CREATE SCHEMA IF NOT EXISTS stock_db.external_staging;

CREATE STAGE IF NOT EXISTS stock_db.external_staging.parquetstage;

CREATE OR REPLACE STAGE stock_db.external_staging.parquetstage
    url = 's3://<path/to_parquet_file/location/in_s3'
    credentials = (AWS_KEY_ID = '<AWS_KEY_ID>' AWS_SECRET_KEY = '<AWS_SECRET_KEY>')
    file_format= stock_db.file_formats.parquet_format;

LIST @stock_db.external_staging.parquetstage;

SELECT * FROM @stock_db.external_staging.parquetstage;

SELECT
    $1: "symbol",
    $1: "stock_date",
    $1: "1._open",
    $1: "2._high",
    $1: "3._low",
    $1: "4._close",
    $1: "5._volume"
FROM
    @stock_db.external_staging.parquetstage;

SELECT COUNT(*) FROM @stock_db.external_staging.parquetstage;


CREATE OR REPLACE TABLE stock_data_parquet (
    symbol VARCHAR,
    stock_date VARCHAR,
    open VARCHAR,
    high VARCHAR,
    low VARCHAR,
    close VARCHAR,
    volume VARCHAR
);

SELECT * FROM stock_db.public.stock_data_parquet;

COPY INTO stock_db.public.stock_data_parquet
FROM (
    SELECT
        $1: "symbol",
        $1: "stock_date",
        $1: "1._open",
        $1: "2._high",
        $1: "3._low",
        $1: "4._close",
        $1: "5._volume"
    FROM
        @stock_db.external_staging.parquetstage
);

SELECT
    *
FROM
    stock_db.public.stock_data_parquet
LIMIT 5;
