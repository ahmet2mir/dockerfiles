FROM debian:jessie
MAINTAINER Ahmet Demir <ahmet2mir+github@gmail.com>

ENV RELEASE jessie
ENV DEBIAN_FRONTEND noninteractive
ENV SHELL /bin/bash

RUN echo "deb http://ftp.fr.debian.org/debian $RELEASE main contrib non-free" > /etc/apt/sources.list \
    && echo "deb http://ftp.debian.org/debian/ $RELEASE-updates main contrib non-free" >> /etc/apt/sources.list \
    && echo "deb http://security.debian.org/ $RELEASE/updates main contrib non-free" >> /etc/apt/sources.list \
    && apt-get update 

RUN apt-get install -y --no-install-recommends git python-dev python-pip gcc build-essential
RUN apt-get install -y --no-install-recommends nginx supervisor

RUN pip install --upgrade pip virtualenv gunicorn supervisor-stdout

EXPOSE 80
