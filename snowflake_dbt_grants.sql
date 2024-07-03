USE ROLE accountadmin;

CREATE WAREHOUSE IF NOT EXISTS dbt_wh WITH warehouse_size='x-small';
CREATE DATABASE IF NOT EXISTS dbt_db;
CREATE ROLE IF NOT EXISTS dbt_role;

SHOW GRANTS ON WAREHOUSE dbt_wh;
SHOW GRANTS ON DATABASE stock_db;

GRANT usage ON WAREHOUSE dbt_wh TO ROLE dbt_role;
GRANT ROLE dbt_role TO USER npecota;
GRANT ALL ON DATABASE dbt_db TO ROLE dbt_role;
GRANT ALL ON DATABASE stock_db TO ROLE dbt_role;

USE ROLE dbt_role;

CREATE SCHEMA dbt_db.dbt_schema;

SELECT * FROM dbt_db.dbt_schema.stg_pqsd LIMIT 5;



DESC TABLE dbt_db.dbt_schema.int_pqsd;

DESC TABLE dbt_db.dbt_schema.fct_pqsd;



SELECT * FROM dbt_db.dbt_schema.int_pqsd LIMIT 5;

SELECT * FROM dbt_db.dbt_schema.fct_pqsd LIMIT 5;
