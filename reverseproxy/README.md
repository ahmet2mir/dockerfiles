Docker Reverse Proxy
====================

Reverse proxy using nginx. This allow you to use both of root and path reverse proxy like https://mydomain/mypath. You can use HTTP and HTTPS

Since Docker 1.3 (use docker exec).

How to use
----------

Start it:

	docker run --name reverseproxy -d -p 443:443 ahmet2mir/reverseproxy

or -p 80:80 or both.

Use your own SSL certificate:

	docker run --name reverseproxy -d -p 443:443 -v /my/ssl/path:/webapps/ssl ahmet2mir/reverseproxy
	
Then copy you <domain>.crt and <domain>.key in /my/ssl/path. When you need to change your cert, reload nginx (see after)

Save logs:

	docker run --name reverseproxy -d -p 443:443 -v /my/ssl/path:/webapps/ssl -v /my/logs/path:/webapps/logs ahmet2mir/reverseproxy

Add a domain:

	docker exec reverseproxy domain -a --hostname myserver.lan

Delete domain

	docker exec reverseproxy domain -d --hostname myserver.lan

Add path
	
	 docker exec reverseproxy path -a --hostname myserver.lan --ip_address 172.17.0.231 --port 5984 --protocol http --path couchdb

Add root path
	
	 docker exec reverseproxy path -a --hostname myserver.lan --ip_address 172.17.0.231 --port 80 --protocol http --path _root

_root is reserved to root path

Delete path

	docker exec reverseproxy path -d --hostname myserver.lan --path _root

Reload nginx

	docker exec reverseproxy nginx -s reload

Troubleshooting

	docker exec -it reverseproxy /bin/bash
	
Full Example
------------

Reverse a [blogotext](https://github.com/ahmet2mir/dockerfiles/tree/master/blogotext), a [shaarli](https://github.com/ahmet2mir/dockerfiles/tree/master/shaarli) and a [couchdb](https://github.com/ahmet2mir/dockerfiles/tree/master/couchdb) with the blog at root path.

	docker run --name reverseproxy -d -p 443:443 ahmet2mir/reverseproxy
	docker run --name shaarli -d ahmet2mir/shaarli
	docker run --name blogotext -d ahmet2mir/blogotext
	docker run --name couchdb -d fedora/couchdb

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

* Blog: https://myserver.lan/
* Shaarli: https://myserver.lan/shaarli/
* Couchdb: https://myserver.lan/couchdb/

Backup
------

Data are stored in /webapps/

* **cache**: all cached data
* **conf**: nginx conf and server template
* **sites**: enabled sites
* **scripts**: path.sh and domain.sh scripts linked to /usr/bin/path and /usr/bin/domain
* **logs**: domain and nginx logs
* **ssl**: generated site certificates. Each domain have their own certificate

Custom Configuration
-------------

Only sites and scripts folders need to be configured before running container.

	cd /my/webapps
	mkdir {cache,conf,sites,scripts,logs,ssl}

	git clone https://github.com/ahmet2mir/dockerfiles
	cp dockerfiles/reverseproxy/assets/conf/* sites/
	cp dockerfiles/reverseproxy/assets/scripts/* scripts/

	# make you custom to nginx.conf

	docker run --name reverseproxy -d -p 443:443 -v /my/path:/webapps ahmet2mir/reverseproxy

Or edit fig.yml to point to your folder, then

	fig -p myproject -d

Have fun!

License
-------

Apache 2 http://en.wikipedia.org/wiki/Apache_License
