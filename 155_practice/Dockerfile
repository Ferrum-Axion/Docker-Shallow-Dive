FROM alpine:3.20

ARG USER
ENV TZ=America/Chicago
ENV USER=${USER}

RUN apk update && apk add --no-cache nginx

CMD ["nginx", "-g", "daemon off;"]
