#!/bin/bash
set -e

# Wait for Postgres to be ready
until pg_isready -U postgres; do
  sleep 2
done

echo "Postgres is ready. Running all SQL scripts..."

# Function to run SQL scripts
run_sql_scripts() {
  local folder="$1"
  find "$folder" -type f -name "*.sql" | sort | while read -r f; do
    echo "Applying $f"
    psql -U postgres -f "$f"
  done
}

# 1️⃣ Run all init scripts under each subproject
for init_dir in /docker-entrypoint-initdb.d/sql/*/init; do
  if [ -d "$init_dir" ]; then
    echo "Running init scripts in $init_dir"
    run_sql_scripts "$init_dir"
  fi
done

# 2️⃣ Run all DDL scripts under each subproject
for ddl_dir in /docker-entrypoint-initdb.d/sql/*/DDL; do
  if [ -d "$ddl_dir" ]; then
    echo "Running DDL scripts in $ddl_dir"
    run_sql_scripts "$ddl_dir"
  fi
done

echo "✅ All SQL scripts applied successfully."
