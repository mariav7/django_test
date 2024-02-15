#!/bin/bash

tree /static

# Apply database migrations
echo "Applying database migrations..."
python src/manage.py makemigrations
python src/manage.py migrate

# Start server
echo "Starting server..."
# runserver is asynchronous, any command after \
# that will be executed once the server is shutdown
python src/manage.py npminstall
python src/manage.py runserver 0.0.0.0:8000

# node -v
# npm -v

