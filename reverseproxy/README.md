Docker Reverse Proxy
====================

Reverse proxy using nginx.

How to use
----------

Start it:

	docker run --name reverseproxy -d -p 443:443 ahmet2mir/reverseproxy

or with fig

	fig up -p myproject -d

Add a server:

	docker exec reverseproxy add_server --hostname myserver.lan --ip_address 172.17.42.1 --port 8082 --protocol http

Then open

	https://myserver.lan


Troubleshooting
---------------

Since Docker 1.3 you can directly use docker exec

	docker exec -it reverseproxy /bin/bash

Backup
------

Data are stored in /webapps/

* **cache**: all cached data
* **conf**: nginx conf and server template
* **site**: enabled sites
* **scripts**: add_server.sh script linked to /usr/bin/add_server
* **logs**: sites logs
* **ssl**: generated site certificates. Each site have their own certificate

Configuration
-------------

Mount you data to /webapps and be sure that example.conf.tpl contains SERVER_NAME, SERVER_PROTOCOL, SERVER_PORT and SERVER_IP

License
-------

Apache 2 http://en.wikipedia.org/wiki/Apache_License
