from airflow import DAG
from airflow.operators.python import PythonOperator
from airflow.providers.postgres.hooks.postgres import PostgresHook
from datetime import datetime

def query_retail_db():
    hook = PostgresHook(postgres_conn_id="project_postgres", schema="retail_db")
    df = hook.get_pandas_df("SELECT * FROM employees LIMIT 5;")
    print("✅ retail_db sample data:")
    print(df)

with DAG(
    dag_id="query_retail_db",
    start_date=datetime(2025, 1, 1),
    schedule_interval=None,
    catchup=False,
    tags=["postgres", "retail"],
) as dag:
    run_query = PythonOperator(
        task_id="select_retail_db",
        python_callable=query_retail_db,
    )
