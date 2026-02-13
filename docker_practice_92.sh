#!/usr/bin/env bash
##################
# Purpose: Run nginx, validate, logs, run 3 containers on custom network.
# Developer: Tomer M. - tomeaces@gmail.com
# Version: 0.0.1
# Date: 01.01.2026
set -o errexit
set -o nounset
set -o pipefail
##################
set -e

NGINX_NAME="practice_92_docker"

echo "Running nginx container..."
docker container run -d --name "${NGINX_NAME}" nginx

echo "Validating container is running..."
docker container ps
echo "ok"

echo "Container last 10 logs:"
docker container logs --tail 10 "${NGINX_NAME}"

echo "Searching for python images:"
docker search python --limit 10

echo "Running rocky container in detached,"
ROCKY_ID=$(docker container run -d rocky)
echo "Printing rocky /etc/*-release..."
docker container exec -it "${ROCKY_ID}" /bin/bash -c 'cat /etc/*-release'

sleep 1
echo "3 containers on custom network..."
NETWORK_NAME="practice_92_net"
CONTAINER_1="container_1"
CONTAINER_2="container_2"
CONTAINER_3="container_3"

echo "Creating network ${NETWORK_NAME} if it is not already exist.."
if ! docker network inspect "${NETWORK_NAME}" >/dev/null 2>&1; then
  docker network create "${NETWORK_NAME}"
fi

echo "Running 3 containers on network: ${NETWORK_NAME}..."
docker container run -d --name "${CONTAINER_1}" --network "${NETWORK_NAME}" nginx
docker container run -d --name "${CONTAINER_2}" --network "${NETWORK_NAME}" nginx
docker container run -d --name "${CONTAINER_3}" --network "${NETWORK_NAME}" nginx

echo "Containers on network:"
docker ps
echo "Done."
