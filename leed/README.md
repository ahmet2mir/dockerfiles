Docker Leed image
=================

This is a Debian based image with Leed RSS client installed with an Apache webserver listening on port 80. 
The database is not provided.

Please use a reverse proxy like nginx and not the image directly.

How to use
----------

The imade didn't provide the database, so use environment variables to run the app.

    docker run -d -p 8080:8080 --name leed -e DB_HOST="172.17.42.1" -e DB_PORT="3306" -e DB_USER="user" -e DB_PWD="password" -e DB_NAME="leednew" -e LEED_USER="admin" -e LEED_PWD="PAAAS" -e LANG="fr" ahmet2mir/leed


You can use the fig http://fig.sh file and run it with a database from another image https://github.com/ahmet2mir/docker-mysql:

    fig -p myproject up -d

If you need to enter in the app, use nsenter https://github.com/jpetazzo/nsenter and the script docker-enter

    docker-enter leed
    or
    docker-enter leed_leed_1

In Database

    docker-enter leed_db_1

License
-------

Apache 2 http://en.wikipedia.org/wiki/Apache_License
