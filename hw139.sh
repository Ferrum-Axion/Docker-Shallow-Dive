#!/usr/bin/env bash
#
# Author: Matan Elbaz
# Description: Docker volume persistence test with MySQL
# Created: 2026-02-26
#

docker volume create mysql-data

docker run -d --name mysql1 -e MYSQL_ROOT_PASSWORD=root123 -e MYSQL_DATABASE=testdb -p 3306:3306 -v mysql-data:/var/lib/mysql  mysql:8
docker kill mysql1
docker volume inspect mysql-data &>/dev/null
echo $?
docker run -d  --name mysql2 -e MYSQL_ROOT_PASSWORD=root123 -p 3307:3306  -v mysql-data:/var/lib/mysql mysql:8
docker exec mysql2 ls /var/lib/mysql

