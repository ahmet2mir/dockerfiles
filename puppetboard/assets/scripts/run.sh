#!/bin/bash

PUPPETDB_HOST=${PUPPETDB_HOST:-localhost}
PUPPETDB_PORT=${PUPPETDB_PORT:-8080}
PUPPETDB_VERIFY=${PUPPETDB_VERIFY:-False}

# If the container stop, don't run this part
# docker start will run this script
if [ ! -f /.docker_status ]
then

	sed 's,{{ PUPPETDB_HOST }},'"${PUPPETDB_HOST}"',g' -i /webapps/puppetboard/settings.py
	sed 's,{{ PUPPETDB_PORT }},'"${PUPPETDB_PORT}"',g' -i /webapps/puppetboard/settings.py
	sed 's,{{ PUPPETDB_VERIFY }},'"${PUPPETDB_VERIFY}"',g' -i /webapps/puppetboard/settings.py

    echo "************ Create status file to be idempotent"
    echo "done" > /.docker_status
fi

echo "************ Finished. Running Gunicorn in FOREGROUND"
cd /webapps/puppetboard/
gunicorn -b 0.0.0.0:9090 puppetboard.app:app

