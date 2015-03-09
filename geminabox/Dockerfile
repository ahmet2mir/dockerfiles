FROM debian:jessie
MAINTAINER Ahmet Demir <ahmet2mir+github@gmail.com>

ENV RELEASE jessie
ENV DEBIAN_FRONTEND noninteractive
ENV SHELL /bin/bash

RUN echo "deb http://ftp.fr.debian.org/debian $RELEASE main contrib non-free" > /etc/apt/sources.list \
    && echo "deb http://ftp.debian.org/debian/ $RELEASE-updates main contrib non-free" >> /etc/apt/sources.list \
    && echo "deb http://security.debian.org/ $RELEASE/updates main contrib non-free" >> /etc/apt/sources.list \
    && apt-get update 

RUN apt-get install -y --no-install-recommends ruby rubygems-integration ruby-dev unicorn
RUN gem install --no-ri --no-rdoc geminabox

RUN mkdir -p /webapps/geminabox/config && \
	mkdir -p /webapps/geminabox/data

WORKDIR /webapps/geminabox/config

COPY assets/conf/config.ru /webapps/geminabox/config/config.ru

EXPOSE 9292

CMD ["unicorn", "-p", "9292"]
