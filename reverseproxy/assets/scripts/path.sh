#!/bin/bash

function usage(){
  printf "Usage: Add or remove a domain.\n"
  printf "\t-a|-d                   : add or delete domain.\n"
  printf "\t--hostname   <hostname> : server hostname.\n"
  printf "\t--ip_address <ip>       : server ip address.\n"
  printf "\t--port       <port>     : port like 80|443.\n"
  printf "\t--protocol   <protocol> : protocole used like http|https.\n"
  printf "\t--path       <path>     : <url>/path.\n"
  printf "\t-h                      : show this message.\n"
}

function main() {

  if [[ $ACTION == "add" ]]
  then
    echo "Adding a path "$SERVER_NAME

    mkdir -p /webapps/conf/$SERVER_NAME/

    if [[ $SERVER_PATH == "_root" ]]
    then
      cp /webapps/conf/root.conf.tpl /webapps/conf/$SERVER_NAME/$SERVER_PATH.conf
      CONF_PATH="root"
    else
      cp /webapps/conf/path.conf.tpl /webapps/conf/$SERVER_NAME/$SERVER_PATH.conf
      CONF_PATH=$SERVER_PATH".conf"
    fi

    /bin/sed 's,{{SERVER_NAME}},'"${SERVER_NAME}"',g' -i /webapps/conf/$SERVER_NAME/$SERVER_PATH.conf
    /bin/sed 's,{{SERVER_PROTOCOL}},'"${SERVER_PROTOCOL}"',g' -i /webapps/conf/$SERVER_NAME/$SERVER_PATH.conf
    /bin/sed 's,{{SERVER_IP}},'"${SERVER_IP}"',g' -i /webapps/conf/$SERVER_NAME/$SERVER_PATH.conf
    /bin/sed 's,{{SERVER_PORT}},'"${SERVER_PORT}"',g' -i /webapps/conf/$SERVER_NAME/$SERVER_PATH.conf
    /bin/sed 's,{{SERVER_PATH}},'"${SERVER_PATH}"',g' -i /webapps/conf/$SERVER_NAME/$SERVER_PATH.conf

    mv /webapps/conf/$SERVER_NAME/$SERVER_PATH.conf /webapps/sites/$SERVER_NAME/$CONF_PATH

    cd /webapps/ssl
    if [ ! -f $SERVER_NAME.key ]
    then
      /usr/bin/openssl req -nodes -new -x509 -keyout $SERVER_NAME.key -out $SERVER_NAME.crt -subj "/C=FR/ST=PARIS/L=ILEDEFRANCE/O=ME/CN=$SERVER_NAME"
    fi

  else
    echo "Removing path "$SERVER_NAME

    if [[ $SERVER_PATH == "_root" ]]
    then
      rm /webapps/sites/$SERVER_NAME/root
      touch /webapps/sites/$SERVER_NAME/root
    else
      rm /webapps/sites/$SERVER_NAME/$SERVER_PATH".conf"
    fi

  fi

  /usr/sbin/nginx -c /webapps/conf/nginx.conf -s reload

  exit 0
}

if [ $# -eq 0 ]
then
  usage
fi

OPTS=$( getopt -o hda -l hostname:,ip_address:,port:,protocol:,path: -- "$@" )
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
    --ip_address) SERVER_IP=$2; shift 2;;
    --port) SERVER_PORT=$2; shift 2;;
    --protocol) SERVER_PROTOCOL=$2; shift 2;;
    --path) SERVER_PATH=$2; shift 2;;
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
if [[ ! $SERVER_IP && $ACTION == "add" ]]; then
  echo "Option --ip_address required." >&2
  exit 1
fi
if [[ ! $SERVER_PORT && $ACTION == "add" ]]; then
  echo "Option --port required." >&2
  exit 1
fi
if [[ ! $SERVER_PROTOCOL && $ACTION == "add" ]]; then
  echo "Option --protocol required." >&2
  exit 1
fi
if [[ ! $SERVER_PATH ]]; then
    echo "Option --path required." >&2
    exit 1
fi

main
