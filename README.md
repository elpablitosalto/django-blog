# Django Blog

A modern blog application built with Django.

## 🚀 Quick Start

### Prerequisites

- Docker
- Docker Compose

### Installation

1. Clone the repository:
```bash
git clone <repository-url>
cd django-blog
```

2. Create a `.env` file with the following content:
```
DEBUG=0
SECRET_KEY=your-secret-key
ALLOWED_HOSTS=localhost,127.0.0.1
DATABASE_URL=postgres://blog:blog@db:5432/blog
```

3. Build and start the containers in detached mode:
```bash
docker compose up -d
```

4. Apply database migrations:
```bash
docker compose exec web python manage.py migrate
```

5. Create a superuser (optional):
```bash
docker compose exec web python manage.py createsuperuser
```

### Accessing the Application

- Blog: http://localhost:8081
- Admin panel: http://localhost:8081/admin

### Development

To view logs:
```bash
docker compose logs -f
```

To stop the application:
```bash
docker compose down
```

To rebuild and restart:
```bash
docker compose up -d --build
```

### Common Issues and Solutions

#### Running Commands After Container Start
If you see the message "w Enable Watch" or need to run additional commands:

1. Press `Ctrl+C` to exit the current process
2. Start containers in detached mode:
```bash
docker compose up -d
```
3. Run your command (e.g., migrations):
```bash
docker compose exec web python manage.py migrate
```

#### Database Connection Issues
If you see "password authentication failed" or other database connection errors:

1. Stop all containers and remove volumes:
```bash
docker compose down -v
```

2. Verify your `.env` file has the correct database URL:
```
DATABASE_URL=postgres://blog:blog@db:5432/blog
```

3. Restart the containers:
```bash
docker compose up -d
```

4. Apply migrations:
```bash
docker compose exec web python manage.py migrate
```

## 📝 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Features
- User registration, login, logout
- Create, read, update, delete (CRUD) articles
- Article authorship and permissions
- Admin interface
- Dockerized deployment with PostgreSQL and Nginx

## Local Development

1. **Clone the repository**
2. **Create and activate a virtual environment:**
   ```bash
   python -m venv venv
   source venv/bin/activate  # On Windows: venv\Scripts\activate
   ```
3. **Install dependencies:**
   ```bash
   pip install -r requirements.txt
   ```
4. **Run migrations:**
   ```bash
   python manage.py migrate
   ```
5. **Create a superuser:**
   ```bash
   python manage.py createsuperuser
   ```
6. **Run the development server:**
   ```bash
   python manage.py runserver
   ```
7. Visit `http://127.0.0.1:8000/` in your browser.

## Docker/PostgreSQL Deployment

1. **Install Docker and Docker Compose (if not already installed):**
   ```bash
   # Create directory for Docker's GPG key
   mkdir -p /etc/apt/keyrings

   # Add Docker's official GPG key
   curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o /etc/apt/keyrings/docker.gpg.new && \
   mv /etc/apt/keyrings/docker.gpg.new /etc/apt/keyrings/docker.gpg
   chmod a+r /etc/apt/keyrings/docker.gpg

   # Add the repository to Apt sources
   echo \
     "deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
     "$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" | \
     tee /etc/apt/sources.list.d/docker.list > /dev/null

   # Update package index and install Docker
   apt update
   apt install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

   # Verify installation
   docker --version
   docker compose version
   ```

2. **Copy `.env.example` to `.env` and set your secrets and DB credentials:**
   ```bash
   cp .env.example .env
   # Edit .env with your settings
   ```

3. **Build and start the containers:**
   ```bash
   docker compose up --build
   ```

4. **Apply migrations and create a superuser inside the web container:**
   ```bash
   Ctrl+C
   docker compose up -d
   docker compose exec web python manage.py migrate
   docker compose exec web python manage.py createsuperuser
   ```

5. **Collect static files:**
   ```bash
   docker compose exec web python manage.py collectstatic --noinput
   ```

6. Visit your domain (e.g. `http://django-blog.pavel-khmelev-portfolio.webtm.ru/`)

## Default Accounts
- Admin: created via `createsuperuser`
- Register new users via the signup page

## Notes
- For production, ensure `DEBUG=0` and set a strong `SECRET_KEY` in your `.env` file.
- Nginx is configured to serve static and media files. 