FROM ubuntu:14.04

ENV DOKKU_VERSION v0.3.18

RUN apt-get update
RUN apt-get -y install \
  apt-transport-https libpcre3 libpcre3-dev libssl-dev wget \
  zip gcc python-software-properties curl git make ruby dnsutils \
  openssh-server

# Empty ssh key file, so dokku does not complain on installation
RUN mkdir /root/.ssh
RUN chown 600 /root/.ssh
RUN touch /root/.ssh/id_rsa.pub

RUN apt-get install -y git make software-properties-common
RUN git clone --branch $DOKKU_VERSION https://github.com/progrium/dokku.git /root/dokku
RUN cd /root/dokku && make install CI=1 DOCKER_VERSION=1.4.1

RUN git clone --branch v1.0.1 --depth 1 https://github.com/sekjun9878/dokku-redis-plugin /var/lib/dokku/plugins/redis

RUN mkdir /var/run/sshd

EXPOSE 22
EXPOSE 80
VOLUME ["/home/dokku"]

ADD start /start
RUN chmod 755 /start
CMD ["/start"]
