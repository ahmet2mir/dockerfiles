FROM tomcat:7
MAINTAINER Ahmet Demir <ahmet2mir+github@gmail.com>

ENV DEBIAN_FRONTEND noninteractive
ENV SHELL /bin/bash

RUN apt-get update && apt-get install multitail

RUN wget https://github.com/MathildeLemee/booking-mvc/raw/master/target/booking-mvc.war -O /usr/local/tomcat/webapps/booking-mvc.war && \
	wget https://jdbc.postgresql.org/download/postgresql-9.4-1200.jdbc4.jar -O /usr/local/tomcat/lib/postgresql-9.4-1200.jdbc4.jar

RUN cd /usr/local/tomcat/lib/ && \
	wget http://mirrors.ircam.fr/pub/apache//commons/dbcp/binaries/commons-dbcp-1.4-bin.tar.gz -O - | tar xzf - && \
	mv commons-dbcp-1.4/commons-dbcp-1.4.jar commons-dbcp-1.4.jar && \
	wget http://mirrors.ircam.fr/pub/apache//commons/pool/binaries/commons-pool-1.6-bin.tar.gz  -O - | tar xzf - && \
	mv commons-pool-1.6/commons-pool-1.6.jar commons-pool-1.6.jar

# tomcat manager configuration
COPY assets/confs/tomcat-users.xml /usr/local/tomcat/conf/tomcat-users.xml
ADD assets/confs /docker

# init script
COPY assets/scripts/run.sh /run.sh
RUN chmod +x /run.sh

EXPOSE 8080

CMD ["/run.sh"]