#!/usr/bin/env bash
#####################################
# Purpuse: 155_practice - Docker Build Arguments
# Created by: Liad Binyamin
# Date: 25/02/2026 
# Version: 0.0.1
set -o errexit
set -o nounset
set -o pipefail
#####################################

# Build the Docker image with tag my-alpine-nginx:0.0.1 and pass argument ninja to USER
docker build -t my-alpine-nginx:0.0.1 --build-arg USER=ninja .

# Run the container from created image
docker run -d --name alpine-nginx-container my-alpine-nginx:0.0.1

# Display container status
docker ps | grep alpine-nginx-container
