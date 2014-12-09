FROM debian:wheezy
MAINTAINER Ahmet Demir <ahmet2mir+github@gmail.com>

ENV RELEASE wheezy
ENV DEBIAN_FRONTEND noninteractive
ENV SHELL /bin/bash

RUN echo "deb http://ftp.fr.debian.org/debian $RELEASE main contrib non-free" > /etc/apt/sources.list \
    && echo "deb http://ftp.debian.org/debian/ $RELEASE-updates main contrib non-free" >> /etc/apt/sources.list \
    && echo "deb http://security.debian.org/ $RELEASE/updates main contrib non-free" >> /etc/apt/sources.list \
    && apt-get update 

RUN apt-get install -y --no-install-recommends git ca-certificates nginx openssl

RUN mkdir -p /webapps/sites /webapps/conf /webapps/logs \
	         /webapps/cache /webapps/scripts /webapps/ssl \
    && chown -R www-data:www-data /webapps
    
COPY assets/scripts /webapps/scripts
COPY assets/conf /webapps/conf/
RUN chmod +x /webapps/scripts/* \
	&& ln -s /webapps/scripts/domain.sh /usr/bin/domain \
	&& ln -s /webapps/scripts/path.sh /usr/bin/path

CMD ["/usr/sbin/nginx","-c","/webapps/conf/nginx.conf"]

EXPOSE 80 443


