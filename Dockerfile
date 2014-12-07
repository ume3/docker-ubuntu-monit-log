# Latest Ubuntu LTS
FROM ubuntu:14.04
MAINTAINER ume3

ENV USER_NAME docker
ENV USER_PASSWORD docker

## install
RUN apt-get update
RUN apt-get upgrade -y
RUN apt-get install sudo passwd openssh-server -y

## setup
# ssh
RUN sed -ri 's/^#PermitRootLogin yes$/PermitRootLogin no/' /etc/ssh/sshd_config

# useradd
RUN useradd $USER_NAME
RUN echo "$USER_NAME:$USER_PASSWORD" | chpasswd
RUN echo "$USER_NAME ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers.d/$USER_NAME
RUN mkdir /var/run/sshd
RUN mkdir /home/${USER_NAME}

## service
# ssh
EXPOSE 22

ENTRYPOINT [ "/usr/sbin/sshd", "-D" ]

