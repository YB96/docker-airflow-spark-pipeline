-- ===============================
-- Curated Layer: Cleaned retail_sales
-- ===============================
\c sql_book_o_reilly

CREATE SCHEMA IF NOT EXISTS transformed;

DROP TABLE IF EXISTS transformed.curated_retail_sales;

CREATE TABLE transformed.curated_retail_sales AS
SELECT
    sales_month,
    kind_of_business,
    sales::NUMERIC AS sales
FROM public.retail_sales
WHERE sales IS NOT NULL;
