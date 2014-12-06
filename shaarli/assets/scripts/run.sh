#!/bin/bash

SHAARLI_USER=${SHAARLI_USER:-admin}
SHAARLI_PWD=${SHAARLI_PWD:-password}
SHAARLI_CONTINENT=${SHAARLI_CONTINENT:-Europe}
SHAARLI_CITY=${SHAARLI_CITY:-Paris}
SHAARLI_TITLE=${SHAARLI_TITLE:-Shaarli}

# If the container stop, don't run this part
# docker start will run this script
if [ ! -f /.docker_status ]
then
    echo "************ Start Apache"
    /usr/sbin/apache2ctl start
    
    echo "************ Make Install"
    echo "setlogin=$SHAARLI_USER&setpassword=$SHAARLI_PWD&continent=$SHAARLI_CONTINENT&city=$SHAARLI_CITY&title=$SHAARLI_TITLE&Save=Save+config"
    curl -iL -XPOST "http://localhost/index.php" -d "setlogin=$SHAARLI_USER&setpassword=$SHAARLI_PWD&continent=$SHAARLI_CONTINENT&city=$SHAARLI_CITY&title=$SHAARLI_TITLE&Save=Save+config"

    echo "************ Stop apache"
    /usr/sbin/apache2ctl stop

    echo "************ Create status file to be idempotent"
    echo "done" > /.docker_status
fi

echo "************ Finished. Running Apache in FOREGROUND"
exec /usr/sbin/apache2ctl -D FOREGROUND
