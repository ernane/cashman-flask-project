# Using lightweight alpine image
FROM python:3.7-alpine

# Installing packages
RUN apk update && apk add --no-cache tzdata
RUN pip install --no-cache-dir pipenv

# Setting Timezone
ENV TZ America/Sao_Paulo

# Defining working directory and adding source code
WORKDIR /usr/src/app
COPY Pipfile Pipfile.lock bootstrap.sh ./
COPY cashman ./cashman

# Install API dependencies
RUN pipenv install

# Start app
EXPOSE 5000
ENTRYPOINT ["/usr/src/app/bootstrap.sh"]
