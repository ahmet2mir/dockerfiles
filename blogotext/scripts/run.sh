#!/bin/bash

BLOGO_USER=${BLOGO_USER:-admin}
BLOGO_PWD=${BLOGO_PWD:-StrongP4ssw0rd1234}
BLOGO_URL=${BLOGO_URL:-"http://localhost/"}
LANG=${LANG:-fr}

# If the container stop, don't run this part
# docker start will run this script
if [ ! -f /.docker_status ]
then
    echo "************ Start Apache"
    /usr/sbin/apache2ctl start

    echo "************ Make Install"
    # curl -iL -XPOST "http://localhost/admin/install.php" -d "langue=$LANG&verif_envoi_1=1&enregistrer=Ok"
    # curl -iL -XPOST "http://localhost/admin/install.php?s=2&l=$LANG" -d "identifiant=$BLOGO_USER&mdp=$BLOGO_PWD&mdp_rep=$BLOGO_PWD&racine=$BLOGO_URL&comm_defaut_status=1&langue=$LANG&verif_envoi_2=1&enregistrer=Ok"
    # curl -iL -XPOST "http://localhost/admin/install.php?s=3&l=$LANG" -d "sgdb=sqlite&langue=$LANG&verif_envoi_3=1&enregistrer=Ok"

    curl -iL -XPOST "http://localhost/admin/install.php" -d "langue=$LANG&verif_envoi_1=1&enregistrer=Ok"
    curl -iL -XPOST "http://localhost/admin/install.php?s=2&l=$LANG" -d "identifiant=$BLOGO_USER&mdp=$BLOGO_PWD&mdp_rep=$BLOGO_PWD&racine=$BLOGO_URL&comm_defaut_status=1&langue=$LANG&verif_envoi_2=1&enregistrer=Ok"
    curl -iL -XPOST "http://localhost/admin/install.php?s=3&l=$LANG" -d "sgdb=sqlite&langue=$LANG&verif_envoi_3=1&enregistrer=Ok"

    rm -rf /var/www/admin/install.php
    
    echo "************ Stop apache"
    /usr/sbin/apache2ctl stop

    echo "************ Create status file to be idempotent"
    echo "done" > /.docker_status
fi

echo "************ Finished. Running Apache in FOREGROUND"
exec /usr/sbin/apache2ctl -D FOREGROUND

