#!/usr/bin/env bash
##################
# Purpose: Clean host, create vaio-net, run alpine/nginx/ubuntu, ping test.
# Developer: Tomer M. - tomeaces@gmail.com
# Version: 0.0.1
# Date: 01.01.2026
set -o errexit
set -o nounset
set -o pipefail
##################
set -e

echo "Clean all containers and images..."
if [ -n "$(docker container ps -aq 2>/dev/null)" ]; then
  docker container stop $(docker container ps -aq)
  docker container rm -f $(docker container ps -aq)
fi
if [ -n "$(docker images -aq 2>/dev/null)" ]; then
  docker image rm -f $(docker images -aq)
fi

echo "Create network vaio-net..."
docker network create vaio-net

echo "Run alpine on vaio-net..."
docker container run -d --name alpine_117 --network vaio-net alpine sleep 300

echo "Run nginx on vaio-net..."
docker container run -d --name nginx_117 --network vaio-net nginx

echo "Run ubuntu/apache2 on default network..."
docker container run -d --name ubuntu_117 ubuntu/apache2

echo "Connect ubuntu_117 to vaio-net..."
docker network connect vaio-net ubuntu_117

echo "Ping from alpine to ubuntu..."
docker container exec alpine_117 apk add -q --no-cache iputils
docker container exec alpine_117 ping -c 2 ubuntu_117

echo "Delete all containers, images and network"
docker container stop alpine_117 nginx_117 ubuntu_117
docker container rm -f alpine_117 nginx_117 ubuntu_117
docker network rm vaio-net
if [ -n "$(docker images -aq 2>/dev/null)" ]; then
  docker image rm -f $(docker images -aq)
fi

echo "Done.."
