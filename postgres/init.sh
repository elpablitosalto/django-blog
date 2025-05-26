#!/bin/bash
set -e

# Create database and user
su - postgres -c "psql -c \"CREATE USER $DB_USER WITH PASSWORD '$DB_PASSWORD';\""
su - postgres -c "psql -c \"CREATE DATABASE $DB_NAME OWNER $DB_USER;\""
su - postgres -c "psql -c \"GRANT ALL PRIVILEGES ON DATABASE $DB_NAME TO $DB_USER;\"" 