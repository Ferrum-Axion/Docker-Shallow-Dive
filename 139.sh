#!/usr/bin/env bash
######################################
# created by: Aviv 
# purpose: Practice 139 solution
# version: 0.0.2
# date: 2026-02-23
######################################
set -o errexit
set -o pipefail
set -o nounset

#create the volume
docker volume create mysql-data

#run container with the volume mounted
docker run -d --name mysql1 -e MYSQL_ROOT_PASSWORD=pass -v mysql-data:/var/lib/mysql mysql:8

#kill the container
docker rm -f mysql1

#check that volume data persists
docker volume inspect mysql-data

#Run a new SQL cntainer with the same volume
docker run -d --name mysql2 -e MYSQL_ROOT_PASSWORD=pass -v mysql-data:/var/lib/mysql mysql:8

#Verify data is intact
docker inspect mysql2