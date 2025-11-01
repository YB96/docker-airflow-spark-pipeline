
\c sql_book_o_reilly;

DROP TABLE IF EXISTS public.date_dim;

CREATE TABLE public.date_dim AS
SELECT 
    date::date,
    to_char(date, 'YYYYMMDD')::int AS date_key,
    date_part('day', date)::int AS day_of_month,
    date_part('doy', date)::int AS day_of_year,
    date_part('dow', date)::int AS day_of_week,
    trim(to_char(date, 'Day')) AS day_name,
    trim(to_char(date, 'Dy')) AS day_short_name,
    date_part('week', date)::int AS week_number,
    to_char(date, 'W')::int AS week_of_month,
    date_trunc('week', date)::date AS week,
    date_part('month', date)::int AS month_number,
    trim(to_char(date, 'Month')) AS month_name,
    trim(to_char(date, 'Mon')) AS month_short_name,
    date_trunc('month', date)::date AS first_day_of_month,
    (date_trunc('month', date) + interval '1 month - 1 day')::date AS last_day_of_month,
    date_part('quarter', date)::int AS quarter_number,
    'Q' || date_part('quarter', date)::int AS quarter_name,
    date_trunc('quarter', date)::date AS first_day_of_quarter,
    (date_trunc('quarter', date) + interval '3 months - 1 day')::date AS last_day_of_quarter,
    date_part('year', date)::int AS year,
    (date_part('decade', date)::int * 10) AS decade,
    date_part('century', date)::int AS century
FROM generate_series('1770-01-01'::date, '2030-12-31'::date, interval '1 day') AS date;
