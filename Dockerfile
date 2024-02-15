
# # Latest version
# FROM node:21

# WORKDIR /code

# # Copy project
# COPY src/ /code/src/
# # Changing to static folder
# WORKDIR /code/src/static
# # Installing js packages
# RUN npm install --save


# # Latest version of Python
# FROM python:3.10

# RUN apt-get update && apt-get install -y tree

# WORKDIR /code

# #  Prevents Python from buffering stdout and stderr
# ENV PYTHONUNBUFFERED 1

# ENV PYTHONDONTWRITEBYTECODE 1

# # Install Pipenv; 
# RUN pip install pipenv 
# # django psycopg2-binary

# # Install dependencies
# COPY services/django/dependencies/Pipfile services/django/dependencies/Pipfile.lock* ./

# RUN pipenv install --deploy --system

# # Copy start script
# COPY services/django/scripts/start_django.sh /code/

# # Give execution permission to the script
# RUN chmod +x /code/start_django.sh

# First stage
# Node.js Application Setup
FROM node:21 AS node_setup

# Creating static folder 
RUN mkdir static
# Copy project
COPY ./frontend ./static
# Changing to static folder
WORKDIR /static
# Installing js packages
RUN npm install --save

# Second stage
# Python and Django Setup
FROM python:3.10

WORKDIR /code
# # Copy artifacts from the first stage (Node.js setup)
COPY --from=node_setup /static /code/frontend

# Continue with the rest of your setup ...
RUN apt-get update && apt-get install -y tree


ENV PYTHONUNBUFFERED  1
ENV PYTHONDONTWRITEBYTECODE  1

# Install Pipenv; 
RUN pip install pipenv 
# django psycopg2-binary

WORKDIR /code

# Copy Pipfile
COPY services/django/dependencies/Pipfile services/django/dependencies/Pipfile.lock* /code/

# Install pip env from Pipfile
RUN pipenv install --deploy --system

# Copy project
COPY src/ /code/src/

RUN cp -r /code/frontend /code/src/static/

# Copy start script
COPY services/django/scripts/start_django.sh /code/

# Give execution permission to the script
RUN chmod +x /code/start_django.sh