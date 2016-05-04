Docker Geminabox image
=================

This is a Debian based image with [Geminabox](https://github.com/geminabox/geminabox) listening on port 9292. 

Quickstart
----------
	
	docker run -d -p 9292:9292 --name geminabox ahmet2mir/geminabox

By default, there is no authentication on **upload**. To enable it pass variable environment:

	docker run -d -p 9292:9292 -P -h geminabox --name geminabox -e USERNAME=myuser -e PASSWORD=mypassword ahmet2mir/geminabox


If you need to enter in the app, use docker exec since Docker 1.3 https://github.com/ahmet2mir/docker-memo

    docker exec -it geminabox /bin/bash

Then visit http://localhost:9292

Configuration
-------------

### Data Store and persistent storage

* packages: mount to /webapps/geminabox/data
* config: mount to /webapps/geminabox/config.ru

If you mount data, when you stop, destroy your container and then run it, data are preserved.

### Password and user

If you wan't to use different configuration for authentication, mount config folder containing your own config.ru
Check [Geminabox Wiki](https://github.com/geminabox/geminabox/wiki/Http-Basic-Auth)

### Make everything private with auth protection

Use environment variable `PRIVATE`

	PRIVATE: true

### Logs

Output are in docker log collect 
	
	docker logs -f geminabox

-f like tail -f

With fig
--------

	mkdir /tmp/{data,config}
	cp config.ru /tmp/config/

fig.yml

	geminabox:
	    image: ahmet2mir/geminabox
	    ports:
	        - "9292:9292"
	    environment:
	        USERNAME: "myuser"
	        PASSWORD: "mypassword"
	    volumes:
	        - /tmp/data:/webapps/geminabox/data
	        - /tmp/config:/webapps/geminabox/config


Run it

	fig up -d

License
-------

Apache 2 http://en.wikipedia.org/wiki/Apache_License


