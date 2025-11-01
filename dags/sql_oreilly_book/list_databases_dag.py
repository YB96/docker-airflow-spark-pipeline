from airflow import DAG
from airflow.operators.python import PythonOperator
from airflow.providers.postgres.hooks.postgres import PostgresHook
from datetime import datetime

def list_databases():
    hook = PostgresHook(postgres_conn_id="project_postgres")
    sql = "SELECT datname FROM pg_database WHERE datistemplate = false;"
    df = hook.get_pandas_df(sql)
    print("✅ Databases in Postgres:")
    print(df)

with DAG(
    dag_id="list_databases_dag",
    start_date=datetime(2025, 1, 1),
    schedule_interval=None,
    catchup=False,
    tags=["postgres", "debug"],
) as dag:

    task = PythonOperator(
        task_id="list_databases",
        python_callable=list_databases,
    )
