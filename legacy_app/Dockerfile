FROM debian:stable

RUN apt update && apt install -y openssh-server && \
    mkdir -p /var/run/sshd

RUN useradd -m legacyssh -s /bin/bash && \
    echo "legacyssh:legacyssh123" | chpasswd

EXPOSE 22

CMD ["/usr/sbin/sshd", "-D"]