#!/bin/bash

#########################
# Created by: Elena Kuznetsov
# Purpose: Docker Practice
# Version: 0.0.1
# Date: 26.2.26
#########################

docker rm -f $(docker ps -aq)
docker rmi -f $(docker images -q)

docker network create vaio-net

docker run -dit --name alpine-cont --network vaio-net alpine /bin/sh
docker run -d --name nginx-cont --network vaio-net nginx
docker run -d --name apache-cont ubuntu/apache2

docker exec alpine-cont ping -c 2 apache-cont

docker network connect vaio-net apache-cont

docker exec alpine-cont ping -c 2 apache-cont

docker rm -f alpine-cont nginx-cont apache-cont
docker rmi -f alpine nginx ubuntu/apache2
docker network rm vaio-net
