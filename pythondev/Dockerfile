FROM alpine:edge
MAINTAINER Ahmet Demir <ahmet2mir+github@gmail.com>

RUN apk add --update bash g++ gcc git libc-dev libffi-dev linux-headers make openssl openssl-dev py-setuptools python python-dev python3 python3-dev swig
RUN easy_install-2.7 pip && easy_install-3.5 pip
RUN pip install --upgrade pip virtualenv gunicorn setuptools
RUN rm -rf /var/cache/apk/*
RUN mkdir /apps

WORKDIR /apps
