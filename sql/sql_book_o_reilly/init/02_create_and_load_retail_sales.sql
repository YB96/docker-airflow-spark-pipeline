-- 02_create_and_load_retail_sales.sql

\c sql_book_o_reilly;

DROP TABLE IF EXISTS retail_sales;

CREATE TABLE retail_sales (
    sales_month DATE,
    naics_code VARCHAR,
    kind_of_business VARCHAR,
    reason_for_null VARCHAR,
    sales DECIMAL
);

COPY retail_sales
FROM '/datafiles/sql_book_o_reilly/raw/retail_sales/us_retail_sales.csv'
DELIMITER ','
CSV HEADER;
