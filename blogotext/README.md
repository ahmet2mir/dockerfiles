Docker Blogotext image
=================

This is a Debian based image with [Blogotext](http://lehollandaisvolant.net/blogotext/) installed with an Apache webserver listening on port 80. 

How to use
----------
	
	docker run -d -p 8080:80 ahmet2mir/blogotext

with default config

	user: "admin"
    password: "StrongP4ssw0r$~d"
    url: "http://localhost/"
    lang: "fr"

Or your own

    docker run -d -p 8080:80 --name blogotext \
    -e BLOGO_USER="admin" \
    -e BLOGO_PWD="password" \
    -e BLOGO_URL="http://localhost/" \
    -e LANG="fr" \
    ahmet2mir/blogotext

You can use the fig http://fig.sh file and run it:

    fig -p blogotext up -d

If you need to enter in the app, use docker exec since Docker 1.3 https://github.com/ahmet2mir/docker-memo

    docker exec -it blogotext /bin/bash
    or if fig used
    docker exec -it blogotext_blogotext_1 /bin/bash

Then visit http://localhost:8080 and admin http://localhost:8080/admin

License
-------

Apache 2 http://en.wikipedia.org/wiki/Apache_License
