#!/bin/bash
set -e

CONTAINER_DATA="/var/lib/postgresql/13/main"
PGDATA="/var/lib/postgresql/13/main"
TEMP_DATA="/tmp/postgresql/13/main"

# Ensure directories exist with correct permissions
mkdir -p "$PGDATA"
chown -R postgres:postgres "$PGDATA"
chmod 700 "$PGDATA"

# Check if database is already initialized in container
if [ ! -s "$CONTAINER_DATA/PG_VERSION" ]; then
    echo "Initializing PostgreSQL database in container..."
    /usr/lib/postgresql/13/bin/initdb -D "$CONTAINER_DATA"
fi

# Check if volume is empty
if [ ! -s "$PGDATA/PG_VERSION" ]; then
    echo "Copying initialized database to volume..."
    cp -a "$CONTAINER_DATA/." "$PGDATA/"
    chown -R postgres:postgres "$PGDATA"
    chmod 700 "$PGDATA"
fi

# Ensure postgres user owns the data directory
chown -R postgres:postgres "$PGDATA"
chmod 700 "$PGDATA"

# Execute the CMD
exec "$@" 