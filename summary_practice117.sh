#!/usr/bin/env bash
####################################
# Created by: Yaron
# Purpose: homework Page 117 
# Date: 22.02.2026
# Version: 0.0.1
set -o errexit
set -o pipefail
set -o nounset
NULL=/dev/null
###################################

function main {
   local cleannetwork="false"
   printf "Delete all older conatiners and images\n"
   if ! cleanup $cleannetwork;
   then
      printf "Could not delete all, please check and retry\n"
      exit 1
   fi
   printf "trying to create new containers and new network\n"
   if ! createcontainer;
   then
       printf "Could not create new network and containers, please check and retry\n"
       exit 1
   fi  
   printf "trying to ping from alpine to ubuntu/apache2 (should fail)\n"
   if ! checkping;
   then
       printf "failed to ping from alpine to ubuntu/apache2, please check and retry\n"
       exit 1
   fi    
   printf "Cleaning up\n"
   cleannetwork="true"
   if ! cleanup $cleannetwork;
   then
      printf "Could not delete all, please check and retry\n"
      exit 1
   fi 
}


function cleanup() {
    local cleannetwork=$1
    if [[ $(docker container ps -a -q | wc -l ) -gt 0 ]];
    then 
        docker container stop $(docker container ps -a -q)
        docker container rm $(docker container ps -a -q)
    fi
    if [[ $(docker images ps -q | wc -l ) -gt 0 ]];
    then 
        docker images rm $(docker image ps -q)
    fi
    echo $cleannetwork
    if [[ $cleannetwork == "true" ]];
    then 
       docker network rm vaio-net
    fi
    return 0
}
 

function createcontainer {
    
    if ! docker network inspect vaio-net >NULL 2>&1;
    then 
        docker network create vaio-net
    fi
    docker run -dit --network vaio-net --name alpine alpine /bin/sh
    docker run -dit --network vaio-net --name nginx nginx
    docker run -dit --name apache ubuntu/apache2
    return 0
}

function checkping() {

    docker exec alpine ping apache
    docker network connect vaio-net apache 
    return 0
}









#################33
main