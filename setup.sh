#!/bin/bash
##################################
# created by: bibi
# purpose: building and running the docker
# version: 0.0.1
# date: 20206-03-22
##################################

docker build -t ssh-server .
docker run -p 2222:22 ssh-server
echo "Connect using: ssh username@localhost -p 2222"
docker rm -f ssh-server