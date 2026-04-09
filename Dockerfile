FROM debian:stable-slim

# Update and install ssh server
RUN apt-get update && apt-get install -y openssh-server

# Need this folder for sshd to run
RUN mkdir -p /var/run/sshd

# Create a user for testing
RUN useradd -m -s /bin/bash devuser
RUN echo 'devuser:password123' | chpasswd

# allow ssh login
RUN sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin no/' /etc/ssh/sshd_config

EXPOSE 22

# Run sshd in the foreground
CMD ["/usr/sbin/sshd", "-D"]
