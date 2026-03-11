# Docker Volumes Practice – MySQL

## Goal
Demonstrate data persistence using Docker volumes.

## Step 1 – Create Volume

docker volume create mysql-data

## Step 2 – Run MySQL Container

docker run -d --name mysql1 \
-e MYSQL_ROOT_PASSWORD=1234 \
-v mysql-data:/var/lib/mysql \
mysql:8.0

## Step 3 – Create Database

docker exec -i mysql1 mysql -uroot -p1234 \
-e "CREATE DATABASE testdb;"

## Step 4 – Insert Data

docker exec -i mysql1 mysql -uroot -p1234 \
-e "USE testdb; CREATE TABLE t1(id INT PRIMARY KEY, name VARCHAR(50)); INSERT INTO t1 VALUES (1,'hello');"

## Step 5 – Remove Container

docker rm -f mysql1

## Step 6 – Start New Container

docker run -d --name mysql2 \
-e MYSQL_ROOT_PASSWORD=1234 \
-v mysql-data:/var/lib/mysql \
mysql:8.0

## Step 7 – Verify Data

docker exec -i mysql2 mysql -uroot -p1234 \
-e "USE testdb; SELECT * FROM t1;"

Result: Data persisted using Docker volume.
