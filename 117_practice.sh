#!/usr/bin/env bash
#####################################
# Purpuse: 117_practice - Docker Networks
# Created by: Liad Binyamin
# Date: 25/02/2026 
# Version: 0.0.1
set -o errexit
set -o nounset
set -o pipefail
#####################################

# Checks if docker is installed 
docker_installed(){
    if ! command -v docker &>/dev/null;
    then
        echo "Docker is not installed, please install Docker to continue."
        exit 1
    else
        echo "Docker is installed. Proceeding with the script."
    fi
}

# Checks if the user has permission to run docker commands (docker group)
check_docker_permission(){
    if groups $USER | grep docker || [ "$EUID" -eq 0 ]
    then
        echo "User has permission to run Docker commands."
    else
        echo "User does not have permission to run Docker commands. Please add your user to the docker group or run the script as root."
        exit 1
    fi
}

# 1. Clean all containers and image from your host
clean_docker(){
    docker stop $(docker ps -aq) 
    docker rm $(docker ps -aq)
}

# 2. Create docker network named vaio-net
create_docker_network(){
    docker network create vaio-net
}

# 3-5. Run alpine and nginx on vaio-net network, and ubuntu/apache2 on default network
run_alpine_container(){
    docker run -dit --name alpine-container --network vaio-net alpine:3.20 sh
    docker run -dit --name nginx-container --network vaio-net nginx:latest
    docker run -dit --name apache2-container ubuntu/apache2:latest
}

# 6. Run from alpine container ping command to test connectivity with ubuntu/apache2
test_connectivity(){
    docker exec alpine-container ping -c 4 apache2-container
    echo " Note: the ping command will fail because alpine and ubuntu containers are not on the same network."
}

# 7. connect already running ubuntu/apache2 container to vaio-net
connect_apache2_to_vaio_net(){
    docker network connect vaio-net apache2-container
    echo "The apache2 container is now connected to the vaio-net network."
}

main(){
    docker_installed
    check_docker_permission
    clean_docker
    create_docker_network
    run_alpine_container
    test_connectivity
    connect_apache2_to_vaio_net
    clean_docker
    # Also removes the docker network
    docker network rm vaio-net
}
main