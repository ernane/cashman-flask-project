# # Using lightweight alpine image
# FROM python:3.7-alpine

# # Installing packages
# RUN apk update && apk add --no-cache tzdata
# RUN pip install --no-cache-dir pipenv

# # Setting Timezone
# ENV TZ America/Sao_Paulo

# # Defining working directory and adding source code
# WORKDIR /usr/src/app
# COPY Pipfile Pipfile.lock bootstrap.sh ./
# COPY cashman ./cashman

# # Install API dependencies
# RUN pipenv install

# # Start app
# EXPOSE 5000
# ENTRYPOINT ["/usr/src/app/bootstrap.sh"]


# docker build --no-cache -t cashman .
# docker run --rm -it cashman sh
# docker run --name cashman -p 5000:5000 cashman

FROM python:3.7-alpine AS build

WORKDIR /opt/app

RUN apk add --no-cache \
            --upgrade \
    && apk add --no-cache \
               --upgrade \
               tzdata

ENV LC_ALL C.UTF-8
ENV LANG C.UTF-8
ENV TZ America/Sao_Paulo
ENV PIPENV_VERBOSITY=-1

RUN pip install --upgrade pip && pip install pipenv && python -m venv /opt/venv

ENV PATH="/opt/venv/bin:$PATH" VIRTUAL_ENV="/opt/venv"

COPY Pipfile Pipfile.lock /opt/app/

RUN pipenv install --deploy

#
FROM python:3.7-alpine AS release
WORKDIR /opt/app

COPY --from=build /opt/venv /opt/venv


ENV PATH="/opt/venv/bin:$PATH" VIRTUAL_ENV="/opt/venv"

COPY bootstrap.sh /opt/app/
COPY cashman /opt/app/cashman

# Start app
EXPOSE 5000
ENTRYPOINT ["/opt/app/bootstrap.sh"]


