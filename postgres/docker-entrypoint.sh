#!/bin/bash
set -e

PGDATA="/var/lib/postgresql/13/main"
TEMP_DATA="/tmp/postgresql/13/main"

# Ensure directories exist with correct permissions
mkdir -p "$PGDATA"
chown -R postgres:postgres "$PGDATA"
chmod 700 "$PGDATA"

# Check if database is already initialized
if [ ! -s "$PGDATA/PG_VERSION" ]; then
    echo "Initializing PostgreSQL database..."
    /usr/lib/postgresql/13/bin/initdb -D "$PGDATA"
fi

# Ensure postgres user owns the data directory
chown -R postgres:postgres "$PGDATA"
chmod 700 "$PGDATA"

# Execute the CMD
exec "$@" 