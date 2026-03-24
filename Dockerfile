FROM alpine:3.23.3

RUN apk add --no-cache openssh openssh-server

RUN ssh-keygen -A

RUN mkdir -p /root/.ssh

ARG ssh_pub_key

RUN echo "$ssh_pub_key" > /root/.ssh/authorized_keys && chmod 0600 /root/.ssh/authorized_keys

RUN echo "PasswordAuthentication no" >> /etc/ssh/sshd_config

EXPOSE 22

CMD [ "/usr/sbin/sshd", "-D" ]
