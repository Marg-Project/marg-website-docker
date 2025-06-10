#!/bin/sh

# Collect static files (optional)
python manage.py collectstatic --noinput

# Start the Django application using Gunicorn
gunicorn --bind 0.0.0.0:8000 --workers 3 --timeout 180 --worker-class sync Marg.wsgi:application

wait