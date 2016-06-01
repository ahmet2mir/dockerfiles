FROM alpine:edge
MAINTAINER Ahmet Demir <ahmet2mir+github@gmail.com>

RUN apk add --update python python3 python3-dev python-dev py-setuptools openssl git bash gcc make g++ openssl-dev libffi-dev
RUN easy_install-2.7 pip && easy_install-3.5 pip
RUN pip install --upgrade pip virtualenv gunicorn setuptools
RUN rm -rf /var/cache/apk/*
RUN mkdir /apps

WORKDIR /apps
