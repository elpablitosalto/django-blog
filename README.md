# Django Blog

A simple blog platform built with Django, supporting article creation, editing, deletion, and user authentication.

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

1. **Copy `.env.example` to `.env` and set your secrets and DB credentials.**
2. **Build and start the containers:**
   ```bash
   docker-compose up --build
   ```
3. **Apply migrations and create a superuser inside the web container:**
   ```bash
   docker-compose exec web python manage.py migrate
   docker-compose exec web python manage.py createsuperuser
   ```
4. **Collect static files:**
   ```bash
   docker-compose exec web python manage.py collectstatic --noinput
   ```
5. Visit your domain (e.g. `http://django-blog.pavel-khmelev-portfolio.webtm.ru/`)

## Default Accounts
- Admin: created via `createsuperuser`
- Register new users via the signup page

## Notes
- For production, ensure `DEBUG=0` and set a strong `SECRET_KEY` in your `.env` file.
- Nginx is configured to serve static and media files. 