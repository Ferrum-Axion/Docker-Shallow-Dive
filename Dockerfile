FROM debian:12-slim 
RUN apt-get update && apt-get install openssh-server -y --no-install-recommends && \
    mkdir /var/run/sshd && \
    sed -i -E 's/^#?PasswordAuthentication.*/PasswordAuthentication yes/' /etc/ssh/sshd_config && \
    sed -i -E 's/^#?UsePAM.*/UsePAM no/' /etc/ssh/sshd_config && \
    ssh-keygen -A && \
    useradd -m -s /bin/bash username && echo "username:password" | chpasswd
CMD ["/usr/sbin/sshd", "-D"]
