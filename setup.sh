#!/usr/bin/env bash
################################
# Developer: Aviv
# Purpose: Setup and run the SSH server container
# Version: 0.0.1
# Date: 22.3.26
set -o errexit
set -o pipefail
set -o nounset
################################
echo "building & starting SSH server container..."
docker compose up -d --build

echo "Done (password: 1234)"
