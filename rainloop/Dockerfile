FROM debian:wheezy
MAINTAINER Ahmet Demir <ahmet2mir+github@gmail.com>

ENV RELEASE wheezy
ENV DEBIAN_FRONTEND noninteractive
ENV SHELL /bin/bash

RUN echo "deb http://ftp.fr.debian.org/debian $RELEASE main contrib non-free" > /etc/apt/sources.list \
    && echo "deb http://ftp.debian.org/debian/ $RELEASE-updates main contrib non-free" >> /etc/apt/sources.list \
    && echo "deb http://security.debian.org/ $RELEASE/updates main contrib non-free" >> /etc/apt/sources.list \
    && apt-get update \
    && apt-get -y upgrade

RUN apt-get install -y --no-install-recommends runit curl git ca-certificates apt-utils apt-transport-https lsb-release unzip nginx php5-fpm php5-curl php5-pgsql php5-mysql php5-sqlite php5-json

# Adding files
ADD . /docker

RUN mkdir -p /webapps/rainloop /webapps/logs/rainloop && \
    cd /tmp && \
    curl -R -L -O "http://repository.rainloop.net/v2/webmail/rainloop-latest.zip" && \
    unzip rainloop-latest.zip -d /webapps/rainloop && \
    find /webapps/rainloop -type d -exec chmod 755 {} \; && \
    find /webapps/rainloop -type f -exec chmod 644 {} \; && \
    chown -R www-data:www-data /webapps/rainloop && \
    cp -f /docker/assets/conf/nginx.conf /etc/nginx/nginx.conf &&  \
    cp -f /docker/assets/conf/nginx-rainloop.conf /etc/nginx/sites-available/rainloop.conf &&  \
    ln -s /etc/nginx/sites-available/rainloop.conf /etc/nginx/sites-enabled/rainloop.conf && \
    sed -i 's/;daemonize = yes/daemonize = no/g' /etc/php5/fpm/php-fpm.conf && \
    sed -i 's/post_max_size.*$/post_max_size = 128M/g' /etc/php5/fpm/php.ini && \
    sed -i 's/upload_max_filesize.*$/upload_max_filesize = 128M/g' /etc/php5/fpm/php.ini

# "Configure services"
# Based on https://github.com/mingfang/docker-salt
RUN for dir in /docker/services/*;\
    do echo $dir; chmod +x $dir/run $dir/log/run;\
    ln -sf $dir /etc/service/; done

CMD /usr/sbin/runsvdir-start

# Expose services
EXPOSE 80
