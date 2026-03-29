#!/bin/bash

#########################
# Created by: Elena Kuznetsov
# Purpose: Docker Practice
# Version: 0.0.1
# Date: 26.2.26
#########################

docker volume create mysql-data

docker run -d --name mysql-db -v mysql-data:/var/lib/mysql -e MYSQL_ROOT_PASSWORD=password mysql:8.0

sleep 15

docker kill mysql-db
docker rm mysql-db

docker volume inspect mysql-data

docker run -d --name mysql-db-new -v mysql-data:/var/lib/mysql -e MYSQL_ROOT_PASSWORD=password mysql:8.0

docker logs mysql-db-new

docker rm -f mysql-db-new
docker volume rm mysql-data
