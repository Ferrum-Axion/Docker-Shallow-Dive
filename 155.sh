#!/usr/bin/env bash
###########################################
# created by: Aviv
# purpose: Practice 155 solution 
# version: 0.0.1
# date: 2026-02-24
###########################################
set -o errexit
set -o pipefail
set -o nounset

docker build --build-arg USER=ninja -t my-alpine-nginx:0.0.1 .
docker run -d --name alpine-nginx my-alpine-nginx:0.0.1
