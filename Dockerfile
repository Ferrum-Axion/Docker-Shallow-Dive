FROM alpine:3.20
ARG USER
ENV TZ=America/Chicago
ENV USER=ninja
RUN apk add --no-cache nginx
CMD ["nginx", "-g", "daemon off;"]
