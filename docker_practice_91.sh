#!/usr/bin/env bash
##################
# Purpose: Stop all containers, remove all images, pull Debian, Rocky, Nginx.
# Developer: Tomer M. - tomeaces@gmail.com
# Version: 0.0.1
# Date: 01.01.2026
set -o errexit
set -o nounset
set -o pipefail
##################
set -e

echo "Stopping all containers..."
docker container stop $(docker container ps -aq) 2>/dev/null || true

echo "Deleting all images on host..."
docker image rm -f $(docker images -aq) 2>/dev/null || true

echo "Pulling images: Debian, Rocky, Nginx."
docker image pull debian
docker image pull rocky
docker image pull nginx

echo "Done"
