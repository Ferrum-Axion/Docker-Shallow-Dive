#!/usr/bin/env bash
##########################################
# created by: Aviv
# purpose: Practice 117 solution
# version: 0.0.1
# date: 2026-02-23
##########################################
set -o errexit
set -o pipefail
set -o nounset

#clean up old containers and images
docker container rm -f $(docker container ps -aq) || true
docker image rm -f $(docker image ls -q) || true

docker network create vaio-net

#Start containers
docker run -dit --name alpine1 --network vaio-net alpine sh
docker run -dit --name nginx1 --network vaio-net nginx
docker run -dit --name apache1 ubuntu/apache2

#test ping (will fail - different networks)
docker exec -it alpine1 ping -c 2 apache1

#connect apache to the custom network
docker network connect vaio-net apache1

# Test ping again (should work now)
docker exec -it alpine1 ping -c 2 apache1

#clean up
docker container rm -f $(docker container ps -aq) || true
docker image rm -f $(docker image ls -q) || true
docker network rm vaio-net || true
