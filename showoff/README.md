Docker Showoff image
=================

This is a Debian based image with [showoff](https://github.com/puppetlabs/showoff) listening on port 9090. 

Quickstart
----------
	
	docker run -d -p 9090:9090 --name showoff ahmet2mir/showoff

If you need to enter in the app, use docker exec since Docker 1.3 https://github.com/ahmet2mir/docker-memo

    docker exec -it showoff /bin/bash

Then visit http://localhost:9090, you will see the showoff demo.

Configuration
-------------

### Data Store and persistent storage

* slides: mount to /webapps/showoff

If you mount data, when you stop, destroy your container and then run it, data are preserved.

### Logs

Output are in docker log collect 
	
	docker logs -f showoff

-f like tail -f

Examples
--------

Check my presentations on https://github.com/ahmet2mir/presentations
You will find a script "run.sh"

	bash run.sh mypresfolder

then visit http://localhost:9090

With fig
--------

	Slide are in /tmp/slides

fig.yml

	showoff:
	    image: ahmet2mir/showoff
	    ports:
	        - "9090:9090"
	    volumes:
	        - /tmp/slides:/webapps/showoff

Run it

	fig up -d

License
-------

Apache 2 http://en.wikipedia.org/wiki/Apache_License


