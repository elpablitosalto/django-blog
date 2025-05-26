FROM debian:bullseye-slim

ENV DEBIAN_FRONTEND=noninteractive

# Install PostgreSQL
RUN apt-get update && apt-get install -y \
    postgresql \
    postgresql-contrib \
    && rm -rf /var/lib/apt/lists/*

COPY init.sh /docker-entrypoint-initdb.d/
RUN chmod +x /docker-entrypoint-initdb.d/init.sh

EXPOSE 5432

CMD ["/usr/lib/postgresql/13/bin/postgres", "-D", "/var/lib/postgresql/13/main"] 