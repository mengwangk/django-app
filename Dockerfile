FROM python:3.7-alpine

# Set environment variables
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

# Set the proxy if you are behind firewall
# ENV http_proxy XX
# ENV https_proxy XX

# Set working directory
WORKDIR /app

## Install postgresql required libs
RUN apk update && apk add postgresql-dev gcc python3-dev musl-dev

# Install nodejs npm
RUN apk add --update npm 

# Install pipenv
RUN pip install pipenv
COPY Pipfile Pipfile.lock ./
RUN pipenv install --system

# Copy pipfile to workdir
# COPY Pipfile* ./

# Install required packages
#RUN pipenv lock --requirements > requirements.txt
#RUN pip install -r requirements.txt

# Copy all files to workdir
COPY . .

# Build the frontend
RUN cd frontend && npm install && npm run build

# Build the backend
# RUN python manage.py makemigrations
# RUN python manage.py migrate

# Run at port 8000
EXPOSE 8000
# CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]

ENTRYPOINT ["/docker-entrypoint.sh"]