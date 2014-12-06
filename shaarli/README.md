Docker Shaarli image
=================

This is a Debian based image with [Shaarli](http://sebsauvage.net/wiki/doku.php?id=php:shaarli) installed with an Apache webserver listening on port 80. 

How to use
----------

    docker run -d -p 8080:80 ahmet2mir/shaarli

with default config

    user: "admin"
    password: "password"
    continent: "Europe"
    city: "Paris"
    title: "Shaarli"
    lang: "fr"

Or your own

    docker run -d -p 8080:80 --name shaarli \
    -e SHAARLI_USER="admin" \
    -e SHAARLI_PWD="StrongP4ssw0r$~d" \
    -e SHAARLI_CONTINENT="Europe" \
    -e SHAARLI_CITY="Paris" \
    -e SHAARLI_TITLE="My Amazing Shaarli" \
    -e LANG="fr" \
    ahmet2mir/shaarli

You can use the fig http://fig.sh file and run it:

    fig -p shaarli up -d

If you need to enter in the app, use docker exec since Docker 1.3 https://github.com/ahmet2mir/docker-memo

    docker exec -it shaarli /bin/bash
    or if fig used
    docker exec -it shaarli_shaarli_1 /bin/bash

Then visit http://localhost:8080

Bugs
----

Sometimes you need to check "Stay signed" to be able to login.

License
-------

Apache 2 http://en.wikipedia.org/wiki/Apache_License
