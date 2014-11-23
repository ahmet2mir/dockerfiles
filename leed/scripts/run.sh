#!/bin/bash

DB_HOST=${DB_HOST:-localhost}
DB_PORT=${DB_PORT:-3306}
DB_USER=${DB_USER:-user}
DB_PWD=${DB_1_ENV_DB_USER_PWD:-password}

DB_NAME=${DB_NAME:-leed}
LEED_USER=${LEED_USER:-admin}
LEED_PWD=${LEED_PWD:-password}

LANG=${LANG:-fr}

# if linked container
if [[ $DB_1_PORT_3306_TCP_ADDR ]]; then
    DB_HOST=${DB_1_PORT_3306_TCP_ADDR}
fi
if [[ $DB_1_PORT_3306_TCP_PORT ]]; then
    DB_PORT=${DB_1_PORT_3306_TCP_PORT}
fi
if [[ $DB_1_ENV_DB_USER ]]; then
    DB_USER=${DB_1_ENV_DB_USER}
fi
if [[ $DB_1_ENV_DB_USER_PWD ]]; then
    DB_PWD=${DB_1_ENV_DB_USER_PWD}
fi

# If the container stop, don't run this part
# docker start will run this script
if [ ! -f /.docker_status ]
then
    LIMIT=5
    RET=1
    until [ ${RET} -eq 0 ] || [ ${LIMIT} -eq 0 ]; do
        mysql --user=$DB_USER --host=$DB_HOST --port=$DB_PORT --password=$DB_PWD > /dev/null 2>&1
        RET=$?
        LIMIT=$(( LIMIT-1 ))
        echo "************ Unable to connect to MySQL server. Wait and Try 5 times (LIMIT=$LIMIT)"
        sleep 5
    done

    if [ ${LIMIT} -ne 0 ]; then
        echo "************ Start Apache"
        /usr/sbin/apache2ctl start

        echo "************ Configure DB"
        echo "CREATE DATABASE "$DB_NAME";" | mysql --user=$DB_USER --password=$DB_PWD --host=$DB_HOST --port=$DB_PORT

        echo "************ Make Install"
        curl -iL -XPOST "http://localhost/leed/install.php" -d "install_changeLngLeed=$LANG&root=http%3A%2F%2F0.0.0.0%3A81%2Fleed%2F&mysqlHost=$DB_HOST&mysqlLogin=$DB_USER&mysqlMdp=$DB_PWD&mysqlBase=$DB_NAME&mysqlPrefix=leed_&login=$LEED_USER&password=$LEED_PWD&installButton="

        echo "************ Stop apache"
        /usr/sbin/apache2ctl stop

        echo "************ Create status file to be idempotent"
        echo "done" > /.docker_status
    fi
fi

echo "************ Finished. Running Apache in FOREGROUND"
exec /usr/sbin/apache2ctl -D FOREGROUND
