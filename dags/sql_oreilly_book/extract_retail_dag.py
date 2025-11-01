from airflow import DAG
from airflow.providers.postgres.hooks.postgres import PostgresHook
from airflow.operators.python import PythonOperator
from datetime import datetime
import pandas as pd

def extract_from_postgres():
    hook = PostgresHook(postgres_conn_id="project_postgres", schema="sql_book_o_reilly")
    df = hook.get_pandas_df("SELECT * FROM retail_sales;")
    df.to_csv("/opt/airflow/output_data/retail_sales_raw.csv", index=False)

with DAG(
    "extract_retail_dag",
    start_date=datetime(2025, 1, 1),
    schedule_interval=None,
    catchup=False,
) as dag:
    extract = PythonOperator(
        task_id="extract_postgres",
        python_callable=extract_from_postgres,
    )
