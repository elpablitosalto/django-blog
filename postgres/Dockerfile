FROM debian:bullseye-slim

ENV DEBIAN_FRONTEND=noninteractive

# Install PostgreSQL
RUN apt-get update && apt-get install -y \
    postgresql \
    postgresql-contrib \
    && rm -rf /var/lib/apt/lists/*

COPY init.sh /docker-entrypoint-initdb.d/
RUN chmod +x /docker-entrypoint-initdb.d/init.sh

# Create directory for postgres data
RUN mkdir -p /var/lib/postgresql/13/main \
    && chown -R postgres:postgres /var/lib/postgresql/13/main

# Initialize the database
RUN su - postgres -c "/usr/lib/postgresql/13/bin/initdb -D /var/lib/postgresql/13/main"

EXPOSE 5432

# Switch to postgres user
USER postgres

# Use the correct path to postgres executable
CMD ["/usr/lib/postgresql/13/bin/postgres", "-D", "/var/lib/postgresql/13/main"] 