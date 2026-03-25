#!/usr/bin/env bash
################################
# Developer: Liad Binyamin
# Purpose: Building and running a Docker container with an SSH server via docker-compose.
# Version: 0.0.1
# Date: 25.3.26
set -o errexit
set -o pipefail
set -o nounset
################################

# Make sure to have Docker and Docker Compose installed before running this script.
check_docker_installed() {
    if ! command -v docker &> /dev/null; then
        echo "Docker is not installed. Please install Docker and try again."
        exit 1
    fi

    if ! command -v docker-compose &> /dev/null; then
        echo "Docker Compose is not installed. Please install Docker Compose and try again."
        exit 1
    fi
}

# Checks if the user has permission to run docker commands (docker group)
check_docker_permission(){
    if [ $EUID -eq 0 ] || groups $USER | grep -q docker;
    then
        echo "User has permission to run Docker commands."
    else
        echo "User does not have permission to run Docker commands. Please add your user to the docker group or run the script as root."
        exit 1
    fi
}

main() {
    check_docker_installed
    check_docker_permission

    echo "Pulling the latest Debian image..."
    docker pull debian:latest

    echo "Starting the Docker container..."
    docker-compose up -d

    echo "Docker container is up and running. You can connect to it using SSH on port 2222."
}
main