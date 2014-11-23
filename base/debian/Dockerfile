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

RUN apt-get install -y --no-install-recommends curl git ca-certificates apt-utils apt-transport-https lsb-release

# Install
# git-man libapt-inst1.5 libclass-isa-perl libcurl3 libcurl3-gnutls
# liberror-perl libexpat1 libgcrypt11 libgdbm3 libgnutls26 libgpg-error0
# libgssapi-krb5-2 libidn11 libk5crypto3 libkeyutils1 libkrb5-3
# libkrb5support0 libldap-2.4-2 libncursesw5 libp11-kit0 librtmp0 libsasl2-2
# libsqlite3-0 libssh2-1 libssl1.0.0 libswitch-perl libtasn1-3 mime-support
# openssl perl perl-base perl-modules python python-minimal python2.7
# python2.7-minimal
