#!/bin/bash
set -e

PGDATA="/var/lib/postgresql/13/main"
TEMP_DATA="/tmp/postgresql/13/main"

# Check if database is already initialized
if [ ! -s "$PGDATA/PG_VERSION" ]; then
    echo "Initializing PostgreSQL database..."
    
    # Create temporary directory
    mkdir -p "$TEMP_DATA"
    chown -R postgres:postgres "$TEMP_DATA"
    
    # Initialize in temporary directory
    su - postgres -c "/usr/lib/postgresql/13/bin/initdb -D $TEMP_DATA"
    
    # Copy initialized files to volume
    cp -a "$TEMP_DATA/." "$PGDATA/"
    
    # Clean up
    rm -rf "$TEMP_DATA"
fi

# Execute the CMD
exec "$@" 