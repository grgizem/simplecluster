# Base Image
FROM alpine:3.7

# Maintainer
MAINTAINER Gizem Gur "grgizem@gmail.com"

# Updates
RUN apk add --update \
    mariadb-dev \
    python \
    python-dev \
    py-pip \
    build-base \
  && pip install virtualenv \
  && rm -rf /var/cache/apk/*

WORKDIR /app
COPY . /app

# Required Packages
RUN virtualenv /env && /env/bin/pip install -r /app/requirements.txt

# Run Application
EXPOSE 3000
CMD ["/env/bin/python", "application.py"]
