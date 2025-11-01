-- ===============================
-- Mart Layer: Aggregated monthly sales by business type
-- ===============================

\c sql_book_o_reilly


CREATE SCHEMA IF NOT EXISTS transformed;

DROP TABLE IF EXISTS transformed.mart_retail_sales;

CREATE TABLE transformed.mart_retail_sales AS
SELECT
    year,
    month,
    kind_of_business,
    SUM(sales) AS total_sales
FROM transformed.fact_retail_sales
GROUP BY year, month, kind_of_business
ORDER BY year, month, kind_of_business;
