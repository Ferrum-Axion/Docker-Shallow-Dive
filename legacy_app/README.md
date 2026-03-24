#######################################
# 
#  README.md file for Project:  Legacy App
#
######################################
# Brief discription of the project
#
# This appears under TASKS.md file
#
#  Table of Contents:
#  
#  * Overview
#  * Features
#  * Usage
#  * Configuration info
#  * License
#
######################################

# Features:

1. Dockerfile is used to install needed packages
   and create a folder for ssh to run in container as it is the runtime directory that OpenSSH expect to exist when running
   in addition a user and password created as root user cannot be used in container.
2. Dockercompose.yml contain configuration for ssh server.


# Installation
1. Please run ./setup.sh to start the build and run the ssh server.
2. For testing or working please run the following command:
   ssh legacyssh@localhost -p 2222    
   then enter the cradentials (can be defined and found in Dockerfile)
   
# Configuration
1. if you want to change use/password please update Dockerfile
2. ssh port is 22 and this is exposed in server side, to reach it you need to connect via port 2222 (can also be changed if wanted)


# License Info
This project is licensed under the MIT License - see the LICENSE file for more detailes