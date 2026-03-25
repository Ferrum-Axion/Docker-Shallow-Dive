from ubuntu:22.04

RUN apt update && apt install -y openssh-server

RUN mkdir -p /run/sshd

RUN echo 'root:root' | chpasswd


RUN sed -i 's/#PermitRootLogin.*/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN sed -i 's/#PasswordAuthentication.*/PasswordAuthentication yes/' /etc/ssh/sshd_config


EXPOSE 22

CMD ["/usr/sbin/sshd", "-D"]



