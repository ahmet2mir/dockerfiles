FROM debian:wheezy
MAINTAINER Ahmet Demir <ahmet2mir+github@gmail.com>

ENV RELEASE wheezy
ENV DEBIAN_FRONTEND noninteractive
ENV SHELL /bin/bash

RUN echo "deb http://ftp.fr.debian.org/debian $RELEASE main contrib non-free" > /etc/apt/sources.list;\
	echo "deb http://ftp.debian.org/debian/ $RELEASE-updates main contrib non-free" >> /etc/apt/sources.list;\
	echo "deb http://security.debian.org/ $RELEASE/updates main contrib non-free" >> /etc/apt/sources.list

RUN apt-get update

RUN	apt-get install -y --no-install-recommends apache2 php5 php5-sqlite unzip git ca-certificates curl

RUN curl -R -L -O http://lehollandaisvolant.net/blogotext/blogotext.zip \
    && unzip blogotext.zip -d /tmp \
	&& rm -rf /var/www \
	&& mv /tmp/blogotext /var/www \
	&& chmod 777 -R /var/www \
	&& /bin/sed 's,AllowOverride None,AllowOverride All,g' -i /etc/apache2/sites-available/default

COPY scripts/run.sh /run.sh
RUN chmod +x /run.sh

EXPOSE 80

CMD ["/run.sh"]

