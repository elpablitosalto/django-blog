FROM debian:bullseye-slim

ENV DEBIAN_FRONTEND=noninteractive

# Install Nginx
RUN apt-get update && apt-get install -y \
    nginx \
    && rm -rf /var/lib/apt/lists/*

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"] 