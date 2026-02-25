#!/usr/bin/env bash
#####################################
# Purpuse: 
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

# 1. Create volume name mysql-data
create_mysql_volume(){
    docker volume create mysql-data
}

# 2. Run mysql container in the background and mount it with storage
run_mysql_container(){
    docker run -dit --name mysql-container -v mysql-data:/storage mysql:latest
}

# 3. Kill mysql container
kill_mysql_container(){
    docker kill mysql-container 
    docker rm mysql-container 
}

# 4. Verify that data still exists
volume_data_check(){
    if docker inspect mysql-data > /dev/null 2>&1
    then
        echo "Volume mysql-data exists. Data should still be there."
    else
        echo "Volume mysql-data does not exist. Data may have been lost."
    fi

}

# 5. Run new mysql container background and mount it with the same storage
run_new_mysql_container(){
    docker run -dit --name new-mysql-container -v mysql-data:/storage mysql:latest
    echo "A new mysql container is running with the same volume."
}

# 6. Test that data is the same and not corrupted (accessing remote folder should be enough)
test_data_integrity(){
    docker exec mysql-container sh -c 'echo test > /storage/testfile.txt'
    kill_mysql_container
    run_new_mysql_container
    docker exec new-mysql-container sh -c 'test -f /storage/testfile.txt && echo "Data OK" || echo "Data Missing"'
}

main(){
    docker_installed
    check_docker_permission
    create_mysql_volume
    run_mysql_container
    kill_mysql_container
    volume_data_check
    run_new_mysql_container
    test_data_integrity
}
main