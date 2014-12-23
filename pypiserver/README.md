Docker Pypiserver image
=================

This is a Debian based image with [Pypiserver](https://pypi.python.org/pypi/pypiserver#installation-and-usage-quickstart) listening on port 80. 

Quickstart
----------
	
	docker run -d -p 8080:80 --name pypiserver ahmet2mir/pypiserver

with default config

	user: "pypiserver"
    password: "Pyp1s€rv€r"

If you need to enter in the app, use docker exec since Docker 1.3 https://github.com/ahmet2mir/docker-memo

    docker exec -it pypiserver /bin/bash

Then visit http://localhost:8080

Configuration
-------------

### Data Store

* .htaccess: mount volume to /webapps/pypiserver/private
* packages: mount to /webapps/pypiserver/packages
* logs: mount to /webapps/logs/pypiserver

### Password and user

Mount private folder or enter in the app and run:

	htpasswd -sbc /webapps/pypiserver/private/.htaccess myuser mypassword

### Logs

Output are in docker log collect 
	
	docker logs -f pypiserver

-f like tail -f

License
-------

Apache 2 http://en.wikipedia.org/wiki/Apache_License


