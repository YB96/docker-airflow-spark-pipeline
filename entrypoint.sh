#!/bin/bash
set -e

export PGPASSWORD="password"

echo "⏳ Waiting for PostgreSQL to be fully ready..."
until pg_isready -h postgres -p 5432 -U postgres; do
    sleep 2
done

# ✅ Ensure airflow_db exists
echo "🔍 Checking if airflow_db exists..."
if ! psql -h postgres -U postgres -tAc "SELECT 1 FROM pg_database WHERE datname='airflow_db'" | grep -q 1; then
    echo "📦 Creating airflow_db..."
    createdb -h postgres -U postgres airflow_db
else
    echo "ℹ️ airflow_db already exists, skipping creation."
fi

# ✅ Run migrations safely
echo "🔧 Running Airflow DB migrations..."
airflow db upgrade

# ✅ Create admin user if not exists
if ! airflow users list | grep -q "admin"; then
  echo "👤 Creating Airflow admin user..."
  airflow users create \
    --username admin \
    --firstname admin \
    --lastname user \
    --role Admin \
    --email admin@example.com \
    --password admin
else
  echo "ℹ️ Admin user already exists, skipping."
fi

# ✅ Ensure project_postgres connection is always present
echo "🔗 Ensuring Airflow connections..."
if ! airflow connections get project_postgres >/dev/null 2>&1; then
  airflow connections add project_postgres \
    --conn-type 'postgres' \
    --conn-host 'postgres' \
    --conn-schema 'retail_db' \
    --conn-login 'postgres' \
    --conn-password 'password' \
    --conn-port '5432'
  echo "✅ Added connection project_postgres"
else
  echo "ℹ️ Connection 'project_postgres' already exists, skipping."
fi

# 🟢 Start scheduler + webserver
echo "🚀 Starting Airflow scheduler & webserver..."
airflow scheduler &
exec airflow webserver --port 8089
