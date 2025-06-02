#!/bin/sh

# Collect static files (optional)
python manage.py collectstatic --noinput || true

# Start the Django application using Gunicorn
gunicorn --bind 0.0.0.0:8000 --workers 3 --timeout 90 Marg.wsgi:application


wait