FROM debian:bullseye-slim

ENV DEBIAN_FRONTEND=noninteractive
ENV PGDATA=/var/lib/postgresql/data

# Install PostgreSQL
RUN apt-get update && apt-get install -y \
    postgresql \
    postgresql-contrib \
    && rm -rf /var/lib/apt/lists/*

# Create directories for PostgreSQL data
RUN mkdir -p /var/lib/postgresql/13/main \
    && chown -R postgres:postgres /var/lib/postgresql/13/main \
    && chmod 700 /var/lib/postgresql/13/main \
    && mkdir -p "$PGDATA" \
    && chown -R postgres:postgres "$PGDATA" \
    && chmod 700 "$PGDATA"

# Copy initialization script
COPY init.sh /docker-entrypoint-initdb.d/
RUN chmod +x /docker-entrypoint-initdb.d/init.sh

# Create entrypoint script
COPY docker-entrypoint.sh /
RUN chmod +x /docker-entrypoint.sh

EXPOSE 5432

# Switch to postgres user
USER postgres

ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["/usr/lib/postgresql/13/bin/postgres", "-D", "/var/lib/postgresql/data"] 