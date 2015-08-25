FROM alpine:3.2
MAINTAINER Ahmet Demir <ahmet2mir+github@gmail.com>

RUN apk add --update python openssl git
RUN wget http://bootstrap.pypa.io/get-pip.py
RUN python get-pip.py
RUN pip install --upgrade pip virtualenv gunicorn setuptools
RUN rm -rf /var/cache/apk/*
RUN mkdir /apps

WORKDIR /apps
