#!/usr/bin/env bash
######################################
# created by: Dmitry Porotov
# purpose: 
# version: 0.0.1
# date: 2026-02-15
###################################### 
set -o errexit
set -o pipefail
set -o nounset

if [[ $(docker container ps -a -q | wc -l) -gt 0 ]]; then
    docker container stop $(docker container ps -a -q)
    docker container rm $(docker container ps -a -q)
fi
if [[ $(docker image ls -q | wc -l) -gt 0 ]]; then
    docker image rm $(docker image ls -q)
fi
docker network create vaio-net
docker run -d --network vaio-net alpine
docker run -d --network vaio-net nginx
docker run -d --name apache ubuntu/apache2

docker run -d --network vaio-net alpine sh -c 'ping apache'

sleep 2

docker container rm -f $(docker container ps -a -q)
docker image rm $(docker image ls -q)
docker network rm vaio-net