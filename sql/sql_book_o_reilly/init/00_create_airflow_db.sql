-- ============================================
-- Create airflow_db only if it does not exist
-- ============================================

\connect postgres;

CREATE DATABASE airflow_db
    WITH
    OWNER = postgres
    ENCODING = 'UTF8'
    LC_COLLATE = 'en_US.utf8'
    LC_CTYPE = 'en_US.utf8'
    TEMPLATE = template0
    ALLOW_CONNECTIONS = true;
