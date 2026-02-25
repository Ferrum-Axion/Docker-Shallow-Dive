FROM alpine
ARG USER
ENV TZ=America/Chicago
ENV USER=${USER}
RUN apk update && apk add nginx
CMD nginx -g daemon off;
