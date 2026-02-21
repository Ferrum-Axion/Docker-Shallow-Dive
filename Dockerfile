FROM alpine
RUN apk update && apk add nginx
ARG USER
ENV TZDATA=America/Chicago
CMD ["nginx", "-g", "dameon off";]
