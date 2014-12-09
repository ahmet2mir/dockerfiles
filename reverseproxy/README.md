Docker Reverse Proxy
====================

Reverse proxy using nginx. This allow you to use bot of root and path reverse proxy like http://mydomain/mypath

How to use
----------

Start it:

	docker run --name reverseproxy -d -p 443:443 ahmet2mir/reverseproxy

or with fig

	fig up -p myproject -d

Add a domain:

	docker exec reverseproxy domain -a --hostname myserver.lan

Delete domain

	docker exec reverseproxy domain -d --hostname myserver.lan

Add path
	
	 docker exec reverseproxy path -a --hostname myserver.lan --ip_address 172.17.0.231 --port 5984 --protocol http --path couchdb

_root is reserved to root path

Add root path
	
	 docker exec reverseproxy path -a --hostname myserver.lan --ip_address 172.17.0.231 --port 80 --protocol http --path _root

_root is reserved to root path

Delete path

	docker exec reverseproxy path -d --hostname myserver.lan --path _root

Then open

	https://myserver.lan/path


Full Example
------------

Reverse a [blogotext](https://github.com/ahmet2mir/dockerfiles/tree/master/blogotext), a [shaarli](https://github.com/ahmet2mir/dockerfiles/tree/master/shaarli) and a [couchdb](https://github.com/ahmet2mir/dockerfiles/tree/master/couchdb) with the blog at root path.

	docker run --name reverseproxy -d -p 443:443 ahmet2mir/reverseproxy
	docker run --name shaarli -d ahmet2mir/shaarli
	docker run --name blogotext -d ahmet2mir/blogotext
	docker run --name couchdb -d ahmet2mir/couchdb

	docker exec reverseproxy domain -a --hostname myserver.lan

	docker inspect --format='{{.NetworkSettings.IPAddress}}' blogotext
	172.17.0.10
	docker inspect --format='{{.NetworkSettings.Ports}}' blogotext
	map[80/tcp:<nil>]
	docker exec reverseproxy path -a --hostname myserver.lan --ip_address 172.17.0.10 --port 80 --protocol http --path _root

	docker inspect --format='{{.NetworkSettings.IPAddress}}' shaarli
	172.17.0.20
	docker inspect --format='{{.NetworkSettings.Ports}}' shaarli
	map[80/tcp:<nil>]
	docker exec reverseproxy path -a --hostname myserver.lan --ip_address 172.17.0.20 --port 80 --protocol http --path shaarli
	
	docker inspect --format='{{.NetworkSettings.IPAddress}}' couchdb
	172.17.0.30
	docker inspect --format='{{.NetworkSettings.Ports}}' couchdb
	map[5984/tcp:<nil>]
	docker exec reverseproxy path -a --hostname myserver.lan --ip_address 172.17.0.30 --port 5984 --protocol http --path couchdb

Then visit:

Blog: http://myserver.lan/
Shaarli: http://myserver.lan/shaarli/
Couchdb: http://myserver.lan/couchdb/

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





















docker exec reverseproxy domain -a --hostname amazing.lan
docker exec reverseproxy path -a --hostname amazing.lan --ip_address 172.17.0.201 --port 80 --protocol http --path shaarli
docker exec reverseproxy path -a --hostname amazing.lan --ip_address 172.17.0.250 --port 5984 --protocol http --path couchdb
docker exec reverseproxy path -a --hostname amazing.lan --ip_address 172.17.0.231 --port 80 --protocol http --path _root
