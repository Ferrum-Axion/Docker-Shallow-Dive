# SSH server in a container 
 
## Setup

1. Set the path to your public key in `setup.sh`
2. Run `setup.sh` to build the image

## Usage

1. Run `docker compose up -d` to start the container or run `docker compose up -d --scale ssh=<number>` to start multiple containers
2. Find the ip of the container by running `docker inspect <container_name>`
3. Run `ssh root@<container_ip> -i <path_to_private_key>` to connect to the container