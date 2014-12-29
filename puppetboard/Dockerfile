FROM debian:wheezy
MAINTAINER Ahmet Demir <ahmet2mir+github@gmail.com>

ENV RELEASE wheezy
ENV DEBIAN_FRONTEND noninteractive
ENV SHELL /bin/bash

RUN echo "deb http://ftp.fr.debian.org/debian $RELEASE main contrib non-free" > /etc/apt/sources.list \
    && echo "deb http://ftp.debian.org/debian/ $RELEASE-updates main contrib non-free" >> /etc/apt/sources.list \
    && echo "deb http://security.debian.org/ $RELEASE/updates main contrib non-free" >> /etc/apt/sources.list \
    && apt-get update 

RUN apt-get install -y --no-install-recommends python python-pip git gunicorn ca-certificates

RUN mkdir -p /webapps/logs/puppetboard \
    && git clone https://github.com/puppet-community/puppetboard.git /webapps/puppetboard \
    && cd /webapps/puppetboard \
    && pip install -r requirements.txt

COPY assets/conf/settings.py /webapps/puppetboard/settings.py
COPY assets/scripts/run.sh /run.sh

RUN chmod +x /run.sh

EXPOSE 9090

CMD ["/run.sh"]
