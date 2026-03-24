#!bin/bash/env bash
####################################
# Created by: Bibi
# Purpose: homework
# Date: 2026-02-14
# Version: 0.0.1
set -o errexit
set -o pipefail
set -o nounset
###################################
#assuming there are containers running in the background. if otherwise, comment the next 3 lines or else script will fail
docker stop $(docker ps -a -q)
docker rm $(docker ps -a -q)
docker rmi $(docker images -a -q)
docker network create vaio-net
docker run -dit --name alpine --network vaio-net alpine
docker run -dit --network vaio-net nginx
docker run -dit --name apache ubuntu/apache2
# also next line will fail the script,since containers are not on the same network. but since in the practice itself the ping is before connecting the other container to the netwrok,I assume it was intentional
docker exec alpine ping apache
docker network connect vaio-net apache 
docker stop $(docker ps -a -q)
docker rm $(docker ps -a -q)
docker rmi $(docker images -a -q)
