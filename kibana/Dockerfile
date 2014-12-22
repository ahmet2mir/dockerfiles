FROM debian:wheezy
MAINTAINER Ahmet Demir <ahmet2mir+github@gmail.com>

ENV RELEASE wheezy
ENV DEBIAN_FRONTEND noninteractive
ENV SHELL /bin/bash
ENV VERSION 3.1.2

RUN echo "deb http://ftp.fr.debian.org/debian $RELEASE main contrib non-free" > /etc/apt/sources.list \
    && echo "deb http://ftp.debian.org/debian/ $RELEASE-updates main contrib non-free" >> /etc/apt/sources.list \
    && echo "deb http://security.debian.org/ $RELEASE/updates main contrib non-free" >> /etc/apt/sources.list \
    && apt-get update 

RUN apt-get install -y --no-install-recommends wget unzip ca-certificates nginx openssl

RUN mkdir -p /webapps /webapps/logs/kibana \
    && cd /tmp \
    && wget https://download.elasticsearch.org/kibana/kibana/kibana-$VERSION.zip -O kibana.zip\
    && unzip kibana.zip -d /tmp/ \
    && mv /tmp/kibana-$VERSION /webapps/kibana \
    && find /webapps/kibana -type d -exec chmod 755 {} \; \
    && find /webapps/kibana -type f -exec chmod 644 {} \; \
    && chown -R www-data:www-data /webapps/kibana

COPY assets/conf/nginx.conf /etc/nginx/nginx.conf
COPY assets/conf/nginx-kibana.conf /etc/nginx/sites-available/kibana.conf
COPY assets/conf/config.js /webapps/kibana/config.js
COPY assets/scripts/run.sh /run.sh

RUN ln -s /etc/nginx/sites-available/kibana.conf /etc/nginx/sites-enabled/kibana.conf \
    && chown -R www-data:www-data /etc/nginx \
    && chmod +x /run.sh

CMD ["/run.sh"]

EXPOSE 80

