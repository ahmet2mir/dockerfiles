FROM debian:wheezy
MAINTAINER Ahmet Demir <ahmet2mir+github@gmail.com>

ENV RELEASE wheezy
ENV DEBIAN_FRONTEND noninteractive
ENV SHELL /bin/bash

RUN echo "deb http://ftp.fr.debian.org/debian $RELEASE main contrib non-free" > /etc/apt/sources.list \
    && echo "deb http://ftp.debian.org/debian/ $RELEASE-updates main contrib non-free" >> /etc/apt/sources.list \
    && echo "deb http://security.debian.org/ $RELEASE/updates main contrib non-free" >> /etc/apt/sources.list \
    && apt-get update 

RUN apt-get install -y --no-install-recommends apache2-utils python-dev python-pip
RUN pip install pip2pi pypiserver passlib
RUN mkdir -p /webapps/pypiserver /webapps/pypiserver/private\
    /webapps/pypiserver/packages /webapps/logs/pypiserver
RUN htpasswd -sbc /webapps/pypiserver/private/.htaccess pypiserver Pyp1s€rv€r

CMD ["/usr/local/bin/pypi-server","-p","80","-P",\
     "/webapps/pypiserver/private/.htaccess",\
     "/webapps/pypiserver/packages"]

EXPOSE 80
