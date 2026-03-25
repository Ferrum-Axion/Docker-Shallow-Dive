FROM debian:latest

RUN apt-get update && apt-get install -y openssh-server 

RUN echo 'root:VerySecurePassword123' | chpasswd

# "PasswordAuthentication" is already defaults to yes
RUN echo "PermitRootLogin yes" >> /etc/ssh/sshd_config

EXPOSE 22

CMD ["/usr/sbin/sshd", "-D"]