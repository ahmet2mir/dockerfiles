Docker Shaarli image
=================

This is a Debian based image with [Kibana](http://www.elasticsearch.org/overview/kibana/) installed with an Nginx webserver listening on port 80. 
Inspiration from https://github.com/arcus-io/docker-kibana

How to use
----------

    docker run -d -p 8080:80 --name shaarli \
    -e ES_HOST="myes.lan" \
    -e ES_PORT="9200" \
    -e ES_SCHEME="http"
    ahmet2mir/kibana

If you need to enter in the app, use docker exec since Docker 1.3 https://github.com/ahmet2mir/docker-memo

    docker exec -it kibana /bin/bash

Then visit http://localhost:8080

License
-------

Apache 2 http://en.wikipedia.org/wiki/Apache_License
