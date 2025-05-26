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
    
    # Create temporary directory
    mkdir -p "$TEMP_DATA"
    chown -R postgres:postgres "$TEMP_DATA"
    chmod 700 "$TEMP_DATA"
    
    # Initialize in temporary directory
    su - postgres -c "/usr/lib/postgresql/13/bin/initdb -D $TEMP_DATA"
    
    # Copy initialized files to volume
    cp -a "$TEMP_DATA/." "$PGDATA/"
    chown -R postgres:postgres "$PGDATA"
    chmod 700 "$PGDATA"
    
    # Clean up
    rm -rf "$TEMP_DATA"
fi

# Ensure postgres user owns the data directory
chown -R postgres:postgres "$PGDATA"
chmod 700 "$PGDATA"

# Execute the CMD
exec "$@" 