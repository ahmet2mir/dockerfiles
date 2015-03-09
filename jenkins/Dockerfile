FROM debian:jessie
MAINTAINER Ahmet Demir <ahmet2mir+github@gmail.com>

ENV RELEASE jessie
ENV DEBIAN_FRONTEND noninteractive
ENV SHELL /bin/bash
ENV JENKINS_VERSION 1.602
ENV JENKINS_HOME /webapps/jenkins/data

# Debian configuration
RUN echo "deb http://ftp.fr.debian.org/debian $RELEASE main contrib non-free" > /etc/apt/sources.list \
    && echo "deb http://ftp.debian.org/debian/ $RELEASE-updates main contrib non-free" >> /etc/apt/sources.list \
    && echo "deb http://security.debian.org/ $RELEASE/updates main contrib non-free" >> /etc/apt/sources.list \
    && apt-get update 

# Install standard packages
RUN apt-get install -y --no-install-recommends ca-certificates-java daemon default-jre-headless \
											   java-common libnspr4 libnss3 libnss3-1d libpcsclite1 \
											   openjdk-7-jre-headless tzdata-java wget curl net-tools git

# Jenkins
RUN mkdir -p /webapps/jenkins/data \
	&& mkdir -p /webapps/jenkins/app \
    && useradd -d /webapps/jenkins jenkins

WORKDIR /webapps/jenkins/app

RUN wget http://mirrors.jenkins-ci.org/war/$JENKINS_VERSION/jenkins.war -O /webapps/jenkins/app/jenkins.war \
	&& chmod 644 /webapps/jenkins/app/jenkins.war

# Clean
RUN apt-get clean
RUN rm -rf /var/lib/apt/lists/*
RUN rm -rf /var/cache/apt/archives/*

EXPOSE 8080

CMD ["java", "-jar", "/webapps/jenkins/app/jenkins.war"]
