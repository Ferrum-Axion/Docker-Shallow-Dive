#!/bin/bash

# check for compose
if ! command -v docker-compose &> /dev/null
then
    echo "error: docker-compose not found"
    exit 1
fi

# build and run
docker-compose up -d --build

echo "done. connect with: ssh -p 2222 devuser@localhost (pass: password123)"
