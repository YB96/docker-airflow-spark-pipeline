-- Fact Layer: Enriched fact table
-- ===============================

\c sql_book_o_reilly


CREATE SCHEMA IF NOT EXISTS transformed;

DROP TABLE IF EXISTS transformed.fact_retail_sales;

CREATE TABLE transformed.fact_retail_sales AS
SELECT
    d.date_key AS date_id,
    c.kind_of_business,
    c.sales,
    d.year,
    d.month_number AS month,
    d.quarter_number AS quarter
FROM transformed.curated_retail_sales c
JOIN public.date_dim d
  ON d.date = c.sales_month;
