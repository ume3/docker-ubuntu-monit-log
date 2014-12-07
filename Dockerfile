# Latest Ubuntu LTS
FROM ubuntu:14.04
MAINTAINER ume3

ENV USER_NAME docker
ENV USER_PASSWORD docker

## install
RUN apt-get update
RUN apt-get upgrade -y
RUN apt-get install sudo passwd openssh-server -y
RUN apt-get install monit -y
RUN apt-get install curl -y
RUN curl -L http://toolbelt.treasuredata.com/sh/install-ubuntu-trusty-td-agent2.sh | sh

## setup
# ssh
RUN sed -ri 's/^#PermitRootLogin yes$/PermitRootLogin no/' /etc/ssh/sshd_config

# useradd
RUN useradd $USER_NAME
RUN echo "$USER_NAME:$USER_PASSWORD" | chpasswd
RUN echo "$USER_NAME ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers.d/$USER_NAME
RUN mkdir /var/run/sshd
RUN mkdir /home/${USER_NAME}

# monit
RUN mkdir -p /var/monit/
COPY files/monit/monitrc /etc/monit/
RUN chmod 0700 /etc/monit/monitrc

COPY files/monit/sshd.rc /etc/monit/conf.d/
COPY files/monit/td-agent.rc /etc/monit/conf.d/

## service
# ssh
EXPOSE 22
# monit
EXPOSE 2812
# fluentd
EXPOSE 24224

CMD /usr/bin/monit -I  
