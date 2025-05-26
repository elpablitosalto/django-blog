#!/bin/bash
set -e

# Check if database is already initialized
if [ ! -s "$PGDATA/PG_VERSION" ]; then
    echo "Initializing PostgreSQL database..."
    /usr/lib/postgresql/13/bin/initdb -D "$PGDATA"
fi

# Execute the CMD
exec "$@" 