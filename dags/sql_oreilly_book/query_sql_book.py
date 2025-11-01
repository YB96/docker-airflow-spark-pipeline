from airflow import DAG
from airflow.operators.python import PythonOperator
from airflow.providers.postgres.hooks.postgres import PostgresHook
from datetime import datetime

def query_sql_book():
    hook = PostgresHook(postgres_conn_id="project_postgres", schema="sql_book_o_reilly")
    df = hook.get_pandas_df("SELECT * FROM retail_sales LIMIT 5;")
    print("✅ sql_book_o_reilly sample data:")
    print(df)

with DAG(
    dag_id="query_sql_book",
    start_date=datetime(2025, 1, 1),
    schedule_interval=None,
    catchup=False,
    tags=["postgres", "sqlbook"],
) as dag:
    run_query = PythonOperator(
        task_id="select_sql_book",
        python_callable=query_sql_book,
    )
