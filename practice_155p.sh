#!/bin/bash

#########################
# Created by: Elena Kuznetsov
# Purpose: Docker Practice
# Version: 0.0.1
# Date: 26.2.26
#########################

cat <<EOF > Dockerfile
FROM alpine
ARG USER
ENV TZ=America/Chicago
ENV USER=\${USER}
RUN apk update && apk add nginx
CMD ["nginx", "-g", "daemon off;"]
EOF

docker build -t my-alpine-nginx:0.0.1 --build-arg USER=ninja .
docker run -d my-alpine-nginx:0.0.1

rm Dockerfile
