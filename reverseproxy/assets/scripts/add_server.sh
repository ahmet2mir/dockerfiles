#!/bin/bash

function usage(){
  printf "Utilisation du script :\n"
  printf "\t--hostname   <hostname> : server hostname.\n"
  printf "\t--ip_address <ip>       : server ip address.\n"
  printf "\t--port       <port>     : port like 80|443.\n"
  printf "\t--protocol   <protocol> : protocole used like http|https.\n"
  printf "\t-h                      : show this message.\n"
}

function main() {

  # SERVER_NAME=${1:-example.org}
  # SERVER_PROTOCOL=${2:-https}
  # SERVER_IP=${3:-localhost}
  # SERVER_PORT=${4:-443}

  echo $SERVER_NAME
  echo $SERVER_PROTOCOL
  echo $SERVER_PORT
  echo $SERVER_IP

  cp /webapps/conf/example.conf.tpl /webapps/conf/$SERVER_NAME.conf

  /bin/sed 's,{{SERVER_NAME}},'"${SERVER_NAME}"',g' -i /webapps/conf/$SERVER_NAME.conf
  /bin/sed 's,{{SERVER_PROTOCOL}},'"${SERVER_PROTOCOL}"',g' -i /webapps/conf/$SERVER_NAME.conf
  /bin/sed 's,{{SERVER_IP}},'"${SERVER_IP}"',g' -i /webapps/conf/$SERVER_NAME.conf
  /bin/sed 's,{{SERVER_PORT}},'"${SERVER_PORT}"',g' -i /webapps/conf/$SERVER_NAME.conf

  mv /webapps/conf/$SERVER_NAME.conf /webapps/sites/$SERVER_NAME.conf
    
  cd /webapps/ssl 
  /usr/bin/openssl req -nodes -new -x509 -keyout $SERVER_NAME.key -out $SERVER_NAME.crt -subj "/C=FR/ST=PARIS/L=ILEDEFRANCE/O=ME/CN=$SERVER_NAME"

  /usr/sbin/nginx -s reload

  # SERVER_NAME="piwik.lan" SERVER_IP="172.17.42.1" SERVER_PROTOCOL="https" SERVER_PORT="443" bash add_server.sh
}


if [ $# -eq 0 ]
then
  usage
fi

OPTS=$( getopt -o h -l hostname:,ip_address:,port:,protocol: -- "$@" )
if [ $? != 0 ]
then
    exit 1
fi
eval set -- "$OPTS"
 
while test $# -gt 0; do
  case "$1" in
    -h) usage;
      exit 0;;
    --hostname) SERVER_NAME=$2; shift 2;;
    --ip_address) SERVER_IP=$2; shift 2;;
    --port) SERVER_PORT=$2; shift 2;;
    --protocol) SERVER_PROTOCOL=$2; shift 2;;
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

if [[ ! $SERVER_NAME ]]; then
    echo "Option --hostname required." >&2
    exit 1
fi
if [[ ! $SERVER_IP ]]; then
    echo "Option --ip_address required." >&2
    exit 1
fi
if [[ ! $SERVER_PORT ]]; then
    echo "Option --port required." >&2
    exit 1
fi
if [[ ! $SERVER_PROTOCOL ]]; then
    echo "Option --protocol required." >&2
    exit 1
fi

main
