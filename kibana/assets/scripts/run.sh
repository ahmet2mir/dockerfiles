#!/bin/bash

ES_HOST=${ES_HOST:-\"+window.location.hostname+\"}
ES_PORT=${ES_PORT:-9200}
ES_SCHEME=${ES_SCHEME:-http}

# If the container stop, don't run this part
# docker start will run this script
if [ ! -f /.docker_status ]
then

	sed 's,{{ ES_HOST }},'"${ES_HOST}"',g' -i /webapps/kibana/config.js
	sed 's,{{ ES_PORT }},'"${ES_PORT}"',g' -i /webapps/kibana/config.js
	sed 's,{{ ES_SCHEME }},'"${ES_SCHEME}"',g' -i /webapps/kibana/config.js

    echo "************ Create status file to be idempotent"
    echo "done" > /.docker_status
fi

echo "************ Finished. Running Nginx in FOREGROUND"
exec nginx -c /etc/nginx/nginx.conf

