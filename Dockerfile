FROM python:3.7-alpine

# Set the proxy if you are behind firewall
## ENV http_proxy XX
## ENV https_proxy XX

# Set working directory
WORKDIR /app

# Install nodejs npm
RUN apk add --update npm 

# Install pipenv
RUN pip install pipenv

# Copy pipfile to workdir
COPY Pipfile* ./

# Install required packages
RUN pipenv lock --requirements > requirements.txt
RUN pip install -r requirements.txt

# Copy all files to workdir
COPY . .

# Build the front end
RUN cd frontend && npm install && npm run build

# Run at port 8000
EXPOSE 8000
CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]
