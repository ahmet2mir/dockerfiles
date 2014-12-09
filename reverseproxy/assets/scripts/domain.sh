#!/bin/bash

function usage(){
  printf "Usage: Add or remove a domain.\n"
  printf "\t-a|-d                   : add or delete domain.\n"
  printf "\t--hostname   <hostname> : server hostname.\n"
  printf "\t-h                      : show this message.\n"
}

function main() {

  if [[ $ACTION == "add" ]]
  then
    echo "Adding a domain "$SERVER_NAME

    cp /webapps/conf/domain.conf.tpl /webapps/conf/$SERVER_NAME.conf

    /bin/sed 's,{{SERVER_NAME}},'"${SERVER_NAME}"',g' -i /webapps/conf/$SERVER_NAME.conf

    mv /webapps/conf/$SERVER_NAME.conf /webapps/sites/$SERVER_NAME.conf
    mkdir /webapps/sites/$SERVER_NAME
    touch /webapps/sites/$SERVER_NAME/root

    cd /webapps/ssl 
    if [ ! -f $SERVER_NAME.key ]
    then
      /usr/bin/openssl req -nodes -new -x509 -keyout $SERVER_NAME.key -out $SERVER_NAME.crt -subj "/C=FR/ST=PARIS/L=ILEDEFRANCE/O=ME/CN=$SERVER_NAME"
    fi

  else
    echo "Removing domain "$SERVER_NAME
    rm /webapps/sites/$SERVER_NAME.conf
    rm -rf /webapps/sites/$SERVER_NAME
  fi

  /usr/sbin/nginx -s reload

  exit 0
}

if [ $# -eq 0 ]
then
  usage
fi

OPTS=$( getopt -o hda -l hostname: -- "$@" )
if [ $? != 0 ]
then
  exit 1
fi
eval set -- "$OPTS"
 
while test $# -gt 0; do
  case "$1" in
    -h) usage; exit 0;;
    -a) ACTION="add"; shift;;
    -d) ACTION="del"; shift;;
    --hostname) SERVER_NAME=$2; shift 2;;
    --) shift; break;;
    \?)
      echo "Invalid option: -$OPTARG" >&2
      exit 1
      ;;
    :)
      echo "Option -$OPTARG requires an argument." >&2
      exit 1
      ;;
  esac
done

if [[ ! $ACTION ]]; then
  echo "Option -a or -d required." >&2
  exit 1
fi
if [[ ! $SERVER_NAME ]]; then
  echo "Option --hostname required." >&2
  exit 1
fi

main
