#!/bin/bash




start() {
  timeout=${2-100}
  if [[ "$1" == "revproxy" && "$PROXY" == "true" ]]; then
    docker stop $1
  fi
  if [ "$RESTART" == "true" ]; then
    docker stop $1
  fi
  # starts container
  if [ ! "$(docker ps -q -f name=$1)" ]; then
      # checks if exists, and if it is exited, then remove it.
      if [ "$(docker ps -aq -f status=exited -f name=$1)" ]; then
          echo "Removing container $1"
          docker rm $1
      fi
      $1
      echo "Starting $1 container."
  else
    echo "Container $1 already started."
  fi
  # checks healty status
  while [[ "$(docker inspect --format='{{.State.Health.Status}}' $1)" != "healthy" ]]; do
    echo "... checking if $1 is healthy -- ${timeout}s"
    ((timeout = timeout - 10))
    sleep 10
      if [[ "$timeout" -le "0" ]]; then
        echo "$1 Either is not running or is not Healthy"
      fi
  done
  echo "Container $1 is Healthy"
}

usage() {
  helptext="$(cat <<EOF
  -h Help
  -e {path to env file} Allows you to specifiy different environment.
  -r Restarts all containers.
  -b Restarts all containers and builds all images.
  -p {Ip address for Proxy} This allows localhost or external ie 0.0.0.0 (Catution you could expose proxy to the network), resets proxy\n
EOF
)"
  echo "$helptext"
}

## Main program start
echo "\n-------------------------------"
echo "| Devops                        |"
echo "-------------------------------\n"


#get options
SOURCE="./.env"
TURP_FUNCTIONS="./.dockerfunc"
BUILD=""
RESTART=""
PROXY=""
IP=""
while getopts ":hrbwe:p:" arg; do
  case "${arg}" in
    h)
      usage
      exit 1
     ;;
    e)
      SOURCE=${OPTARG}
      echo "Using environment file $SOURCE"
      ;;
    r)
     RESTART="true"
      echo "Restarting all docker images."
      ;;
    b)
      BUILD="true"
      echo "Setting up to Rebuild and restart all images."
      ;;
    p)
      IP=${OPTARG}
      PROXY="true"
      echo 'Restarting Proxy'
      ;;
    *)
      ;;
  esac
done


. $SOURCE
. $TURP_FUNCTIONS
if [[ ! -z "$IP" ]]; then
  HOST=${IP}
fi
echo "Using HOST ${HOST}\n"

containers=('revproxy' 'vscode'  )
#cleanup
#docker rmi $(docker images | grep "^<none>" | awk "{print $3}")
# check if wordpress image is built
if [[ "$(docker images -q  sturple/wordpress 2> /dev/null)" == "" || "$BUILD" == "true" ]]; then
  echo "Couldn't find image sturple/wordpress or rebuild flag set to true\nBuilding Image now..."
  docker build -t sturple/wordpress --no-cache ./builds/wordpress/
fi

count=0
while [ "x${containers[count]}" != "x" ]
do
  start ${containers[count]}
  count=$(( $count + 1 ))
done
echo "\n"
docker ps

exit 1
