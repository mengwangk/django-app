#!/bin/sh

# Wait for postgres to start up completely
sleep 10

# Apply database migrations
python manage.py migrate                  

# Run the server
python manage.py runserver 0.0.0.0:8000

# Prepare log files and start outputting logs to stdout
# touch /app/logs/gunicorn.log
# touch /app/logs/access.log
# tail -n 0 -f /srv/logs/*.log &

# # Start Gunicorn processes
# echo "Starting Gunicorn...."
# exec gunicorn backend.wsgi:application \
#     --name django_app \
#     --bind 0.0.0.0:8000 \
#     --workers 3 \
#     --log-level=info \
#     --log-file=/app/logs/gunicorn.log \
#     --access-logfile=/app/logs/access.log \
#     "$@"