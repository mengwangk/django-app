FROM python:3.7-alpine

# Set environment variables
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

# Set the proxy if you are behind firewall
ENV http_proxy http://m827597:iamrich_12345@web.prod.proxy.cargill.com:4200 
ENV https_proxy http://m827597:iamrich_12345@web.prod.proxy.cargill.com:4200 

# Set working directory
WORKDIR /app

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
RUN python manage.py makemigrations
RUN python manage.py migrate

# Run at port 8000
EXPOSE 8000
CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]

# Use gunicorn - http://michal.karzynski.pl/blog/2015/04/19/packaging-django-applications-as-docker-container-images/
# COPY docker-entrypoint.sh .
# ENTRYPOINT ["/docker-entrypoint.sh"]