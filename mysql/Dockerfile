FROM debian:wheezy
MAINTAINER Ahmet Demir <ahmet2mir+github@gmail.com>

ENV RELEASE wheezy
ENV DEBIAN_FRONTEND noninteractive
ENV SHELL /bin/bash

ENV DB_ROOT_PWD root
ENV DB_USER user
ENV DB_USER_PWD password


# Change sources.list to point on mirrors
RUN echo "deb http://ftp.fr.debian.org/debian $RELEASE main contrib non-free" > /etc/apt/sources.list;\
	echo "deb http://ftp.debian.org/debian/ $RELEASE-updates main contrib non-free" >> /etc/apt/sources.list;\
	echo "deb http://security.debian.org/ $RELEASE/updates main contrib non-free" >> /etc/apt/sources.list

# "Update Repo"
RUN apt-get update

# Mysql
RUN echo "mysql-server mysql-server/root_password password $DB_ROOT_PWD" | debconf-set-selections;\
	echo "mysql-server mysql-server/root_password_again password $DB_ROOT_PWD" | debconf-set-selections;

RUN	apt-get install -y --no-install-recommends mysql-server

# Bind to 0.0.0.0
RUN sed -i -e"s/^bind-address\s*=\s*127.0.0.1/bind-address = 0.0.0.0/" /etc/mysql/my.cnf

# Create an user
RUN /usr/sbin/mysqld & \
    sleep 5s &&\
    echo "GRANT ALL ON *.* TO root@'%' IDENTIFIED BY '$DB_ROOT_PWD'; FLUSH PRIVILEGES" | mysql --user=root --password=$DB_ROOT_PWD &&\
    echo "GRANT ALL ON *.* TO $DB_USER@'%' IDENTIFIED BY '$DB_USER_PWD' WITH GRANT OPTION; FLUSH PRIVILEGES" | mysql --user=root --password=$DB_ROOT_PWD


EXPOSE 3306

CMD ["/usr/bin/mysqld_safe"]