# Docker Networking Practice – 12.2.2026 (Rafi)

## Step 1 – Create network

docker network create docker-net

This creates a user-defined bridge network.

---

## Step 2 – Run two containers on docker-net

docker run -dit --name alpine1 --network docker-net alpine sh
docker run -dit --name alpine2 --network docker-net alpine sh

Both containers are attached to docker-net.

---

## Step 3 – Validate network

docker inspect -f '{{range $k, $v := .NetworkSettings.Networks}}{{$k}}{{end}}' alpine1

Output:
docker-net

---

## Step 4 – Test DNS resolution

docker exec -it alpine1 sh
ping -c 3 alpine2

Result:
Ping successful.

Explanation:
User-defined bridge networks provide embedded DNS.

---

## Step 5 – Cleanup

docker kill alpine1 alpine2
docker rm alpine1 alpine2
docker network rm docker-net
