Docker MySQL image
=================

This is a Debian based image with MySQL server installed listening on port 3306. 

How to use
----------

Run 
    docker run -d -p 3306:3306 --name mysql ahmet2mir/mysql

Connexion informations
----------------------
    
Admin

    login: root
    password: root

Full user

    login: user
    password: password

    mysql --user=root --port=3306 --host=172.17.42.1 --password=root

Please change it (install mysql client first or use something like SQLBuddy or try http://www.cyberciti.biz/faq/mysql-change-root-password/)
    
    mysqladmin --user=root --port=3306 --host=172.17.42.1 --password=root password newpass
    mysqladmin --user=user --port=3306 --host=172.17.42.1 --password=password password newpass

Enter in image
--------------

If you need to enter in the app, use docker exec since Docker 1.3 https://github.com/ahmet2mir/docker-memo

    docker exec -it mysql /bin/bash
    

License
-------

Apache 2 http://en.wikipedia.org/wiki/Apache_License
