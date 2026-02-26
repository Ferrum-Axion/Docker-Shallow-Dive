#!/usr/bin/env bash
#
# Author: Matan Elbaz
# Description: Docker networking and multi-container setup
# Created: 2026-02-26
#

docker stop $(docker ps -aq)
docker rm $(docker ps -aq)
docker rmi -f $(docker images -aq)
docker network create vaio-net
docker run -dit --name alpine1 --network vaio-net alpine sh
docker run -d  --name nginx1  --network vaio-net -p 8080:80   nginx
docker run -dit --name ubuntu-apache -p 8081:80 ubuntu bash
docker exec -it ubuntu-apache bash
apt update
apt install -y apache2
service apache2 start
exit
ip_apache=$(docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' ubuntu-apache)
docker exec alpine1 ping $ip_apache
exit
