FROM alpine:3.2
MAINTAINER Ahmet Demir <ahmet2mir+github@gmail.com>

RUN apk add --update python python3 python3-dev python-dev py-setuptools openssl git bash
RUN easy_install-2.7 pip && easy_install-3.4 pip
RUN pip install --upgrade pip virtualenv gunicorn setuptools
RUN rm -rf /var/cache/apk/*
RUN mkdir /apps

WORKDIR /apps
