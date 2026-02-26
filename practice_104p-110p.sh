  #!/bin/bash
   
  #########################
  # Created by: Elena Kuznetsov
  # Purpose: Docker Practicing
  # Version: 0.0.1
  # Date: 26.2.26
  #########################



docker network create --subnet 192.168.1.0/24 --gateway 192.168.1.1 docker-net

ID=$(docker run -dit --network docker-net alpine /bin/sh)

docker ps
docker inspect $ID

docker kill $ID

docker network rm docker-net

docker run -d -P ubuntu/apache2
docker ps
