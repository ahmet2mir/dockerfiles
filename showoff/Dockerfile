FROM debian:jessie
MAINTAINER Ahmet Demir <ahmet2mir+github@gmail.com>

ENV RELEASE jessie
ENV DEBIAN_FRONTEND noninteractive
ENV SHELL /bin/bash

RUN echo "deb http://ftp.fr.debian.org/debian $RELEASE main contrib non-free" > /etc/apt/sources.list \
    && echo "deb http://ftp.debian.org/debian/ $RELEASE-updates main contrib non-free" >> /etc/apt/sources.list \
    && echo "deb http://security.debian.org/ $RELEASE/updates main contrib non-free" >> /etc/apt/sources.list \
    && apt-get update 

RUN apt-get install -y --no-install-recommends ruby rubygems-integration ruby-dev libxml2 zlib1g-dev git make gcc g++ patch
RUN gem install showoff

RUN mkdir -p /webapps/showoff

RUN cd /tmp && git clone https://github.com/puppetlabs/showoff.git && \
	mv showoff/example/* /webapps/showoff/

WORKDIR /webapps/showoff

VOLUME ["/webapps/showoff"]

# Clean
RUN apt-get clean
RUN rm -rf /var/lib/apt/lists/*
RUN rm -rf /var/cache/apt/archives/*

EXPOSE 9090

CMD ["showoff", "serve"]
