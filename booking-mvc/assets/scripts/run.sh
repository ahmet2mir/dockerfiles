#!/bin/bash

DB_HOST=${DB_HOST:-localhost}
DB_PORT=${DB_PORT:-5432}
DB_USER=${DB_USER:-user}
DB_PASSWORD=${DB_PASSWORD:-password}
DB_NAME=${DB_NAME:-postgres}

TOMCAT_USER=${TOMCAT_USER:-admin}
TOMCAT_PASSWORD=${TOMCAT_PASSWORD:-password}

# If the container stop, don't run this part
# docker start will run this script
if [ ! -f /.docker_status ]
then
	echo ">>>> Tomcat user"
	cp /docker/tomcat-users.xml /usr/local/tomcat/conf/tomcat-users.xml
	sed 's,{{ TOMCAT_USER }},'"${TOMCAT_USER}"',g' -i /usr/local/tomcat/conf/tomcat-users.xml
	sed 's,{{ TOMCAT_PASSWORD }},'"${TOMCAT_PASSWORD}"',g' -i /usr/local/tomcat/conf/tomcat-users.xml

	echo ">>>> Start"
	/usr/local/tomcat/bin/catalina.sh start

	sleep 5

	echo ">>>> Configure DB access"
	cp /docker/data-access-config.xml /usr/local/tomcat/webapps/booking-mvc/WEB-INF/config/data-access-config.xml
	cp /docker/persistence.xml /usr/local/tomcat/webapps/booking-mvc/WEB-INF/classes/META-INF/persistence.xml
	sed 's,{{ DB_HOST }},'"${DB_HOST}"',g' -i /usr/local/tomcat/webapps/booking-mvc/WEB-INF/config/data-access-config.xml
	sed 's,{{ DB_PORT }},'"${DB_PORT}"',g' -i /usr/local/tomcat/webapps/booking-mvc/WEB-INF/config/data-access-config.xml
	sed 's,{{ DB_USER }},'"${DB_USER}"',g' -i /usr/local/tomcat/webapps/booking-mvc/WEB-INF/config/data-access-config.xml
	sed 's,{{ DB_PASSWORD }},'"${DB_PASSWORD}"',g' -i /usr/local/tomcat/webapps/booking-mvc/WEB-INF/config/data-access-config.xml
	sed 's,{{ DB_NAME }},'"${DB_NAME}"',g' -i /usr/local/tomcat/webapps/booking-mvc/WEB-INF/config/data-access-config.xml

	echo ">>>>> Reload configuration"
	curl -XGET --user $TOMCAT_USER:$TOMCAT_PASSWORD "http://localhost:8080/manager/text/reload?path=/booking%2Dmvc"

    echo ">>>>> Create status file to be idempotent"
    echo "done" > /.docker_status
else
	echo ">>>> Start"
	/usr/local/tomcat/bin/catalina.sh start
fi

echo ">>>>> Bring to fron"
tail -f /usr/local/tomcat/logs/catalina.out


# su - postgres
# psql --command "CREATE USER postgres WITH SUPERUSER PASSWORD 'postgres';" && createdb -O postgres postgres


