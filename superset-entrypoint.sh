#!/bin/bash
set -e

# Wait for Postgres using bash's /dev/tcp (no nc needed)
echo "⏳ Waiting for Postgres..."
until (echo > /dev/tcp/postgres/5432) >/dev/null 2>&1; do
  sleep 2
done

echo "✅ Postgres is up - continuing..."

# Upgrade the Superset metadata database
superset db upgrade

# Create admin user if not exists
superset fab create-admin \
   --username "${SUPERSET_ADMIN_USERNAME:-admin}" \
   --firstname "${SUPERSET_ADMIN_FIRSTNAME:-Superset}" \
   --lastname "${SUPERSET_ADMIN_LASTNAME:-Admin}" \
   --email "${SUPERSET_ADMIN_EMAIL:-admin@superset.com}" \
   --password "${SUPERSET_ADMIN_PASSWORD:-admin}" || true

# Initialize roles and permissions
superset init

# Start Superset
superset run -h 0.0.0.0 -p 8088 --with-threads --reload --debugger
