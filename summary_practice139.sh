#!/usr/bin/env bash
####################################
# Created by: Yaron
# Purpose: homework Page 139 
# Date: 25.02.2026
# Version: 0.0.3
set -o errexit
set -o pipefail
set -o nounset
NULL=/dev/null
VOLUMENAME=mysql-data
###################################

function main {
   printf "Delete all older conatiners and images\n"
   if ! cleanup;
   then
      printf "Could not delete all, please check and retry\n"
      exit 1
   fi
   if ! createvolume; 
   then
        printf "Could not create volume, please check and retry\n"
        exit 1
   fi
   printf "trying to create new mysql docker and attach to volume created\n"
   local name="mysqlyaron1"
   if ! createcontainer $name;
   then
       printf "Could not create new network and containers, please check and retry\n"
       exit 1
   fi  
   printf "try to delete the container and check volume still exist\n"
   if ! checkvolume "true";
   then
       printf "failed to delete or vloume not exist, please check and retry\n"
       exit 1
   fi   
   printf "trying to create 2nd mysql docker and attach to same volume \n"
   local name="mysqlyaron2"
   if ! createcontainer $name;
   then
       printf "Could not create new network and containers, please check and retry\n"
       exit 1
   fi  
   printf "Check volume still exist\n"
   if ! checkvolume "false";
   then
       printf "vloume not exist, please check and retry\n"
       exit 1
   fi   
   printf "Cleaning up\n"
   if ! cleanup;
   then
      printf "Could not delete all, please check and retry\n"
      exit 1
   fi 
}


function cleanup() {
    if [[ $(docker container ps -a -q | wc -l ) -gt 0 ]];
    then 
        docker container stop $(docker container ps -a -q)
        docker container rm $(docker container ps -a -q)
    fi
    if [[ $(docker images ps -q | wc -l ) -gt 0 ]];
    then 
        docker images rm $(docker image ps -q)
    fi
    if docker volume inspect "$VOLUMENAME" >NULL 2>&1;
    then 
       docker volume rm "$VOLUMENAME"
    fi
    return 0
}
 
function createvolume {
    if ! docker volume create $VOLUMENAME;
    then
       return 1
    fi
}


function createcontainer {
    local name=$1
    docker run -d --name $name -e MYSQL_ROOT_PASSWORD=1234 -v mysql-data:/var/lib/mysql mysql:8
    return 0
}

function checkvolume() {
    local deletevolume=$1
    if [[ deletevolume == "true" ]];
    then
       docker rm -f mysqlyaron 
    fi
    if ! docker volume inspect mysql-data >NULL 2>&1;
    then
       return 1  
    fi
    return 0
}









#################33
main