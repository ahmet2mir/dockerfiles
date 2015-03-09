Docker Jenkins image
=================

This is a Debian based image with [Jenkins](http://jenkins-ci.org) listening on port 80. 

Quickstart
----------
	
	docker run -d -p 8080:80 --name jenkins ahmet2mir/jenkins

If you need to enter in the app, use docker exec since Docker 1.3 https://github.com/ahmet2mir/docker-memo

    docker exec -it jenkins /bin/bash

Then visit http://localhost:8080

Configuration
-------------

### Data Store

* jenkins home: mount to /webapps/jenkins/data

### Logs

Output are in docker log collect 
	
	docker logs -f jenkins

-f like tail -f

License
-------

Apache 2 http://en.wikipedia.org/wiki/Apache_License


