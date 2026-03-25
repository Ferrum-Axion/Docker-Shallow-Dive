#!/bin/bash
################################
# created by: Matan
# purpose: Automate the build and deployment of an SSH server container
# date: 20206-03-25
################################

echo " building image..."
docker build -t ssh-server .

echo " Running container..."
docker run -d -p 2222:22 --name ssh-server ssh-server

echo " Done! connect using: "
echo "ssh root@localhost -p 2222"
