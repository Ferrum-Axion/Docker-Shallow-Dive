#!/bin/bash
###############################################
# Purpose: Auto build ssh server and start via docker compose
# Developer: Yaron Segev, Yar.Segev@gmail.com
# Version: 0.0.1
# Date: 22.3.2026
set -o errexit
set -o nounset
set -o pipefail
###############################################

function main() {
    printf "1. Build container\n"
    if ! buildcontainer; 
    then 
       printf "Failed to build container\n"
       exit 1
    else
       printf "1. Container built\n"
    fi
    
    printf "2. Start with docker compose\n"
    if ! dockercompose; 
    then 
       printf "failed to start\n"
       exit 1
    else
       printf "2. started ok\n"
    fi
    printf "Container up, try to connect: ssh legacyssh@localhost -p 2222\n" 
}

function buildcontainer() {
    docker build -t ssh-server .
}

function dockercompose() {
    docker compose up -d
}









###################
##   Main
###################
main