#!/usr/bin/env bash
#
# Author: Matan Elbaz
# Description: Build and run custom Alpine Nginx image
# Created: 2026-02-26
#

set -euo pipefail

docker rm -f my-nginx 2>/dev/null || true

docker build --build-arg USER=ninja -t my-alpine-nginx:0.0.1 .

docker run -d --name my-nginx -p 8085:80 my-alpine-nginx:0.0.1

curl -sS http://localhost:8085 || true
echo
echo "Running: http://localhost:8085"
