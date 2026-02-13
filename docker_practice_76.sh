#!/usr/bin/env bash
##################
# Purpose: Create new fedora docker and install vim in it.
# Developer: Tomer M. - tomeaces@gmail.com
# Version: 0.0.1
# Date: 01.01.2026
set -o errexit
set -o nounset
set -o pipefail
##################
set -e

echo "Starting fedora container in detached mode..."
CONTAINER_ID=$(docker container run -d fedora)

echo "Installing vim in container ${CONTAINER_ID}..."
docker container exec "${CONTAINER_ID}" dnf install -y vim

echo "Checking running containers..."
if docker ps; then
  echo "ok"
fi

echo "Container release info:"
docker container exec -it "${CONTAINER_ID}" /bin/bash -c 'cat /etc/*-release'
