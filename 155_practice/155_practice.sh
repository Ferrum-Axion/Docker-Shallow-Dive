#!/bin/bash

# Build the Docker image with tag my-alpine-nginx:0.0.1 and pass argument ninja to USER
docker build -t my-alpine-nginx:0.0.1 --build-arg USER=ninja .

# Run the container from created image
docker run -d --name alpine-nginx-container my-alpine-nginx:0.0.1

# Display container status
docker ps | grep alpine-nginx-container
