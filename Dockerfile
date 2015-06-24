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
RUN git clone --branch patch-1 https://github.com/arthurschreiber/dokku.git /root/dokku

RUN curl -sSL https://get.docker.com/gpg | apt-key add -
RUN echo deb http://get.docker.io/ubuntu docker main > /etc/apt/sources.list.d/docker.list
RUN apt-get update
RUN apt-get install -qq -y lxc-docker-1.4.1

RUN cd /root/dokku && make install CI=1

RUN git clone --depth 1 https://github.com/arthurschreiber/dokku-redis-plugin.git /var/lib/dokku/plugins/redis

RUN mkdir /var/run/sshd

# Disable IPv6
RUN sed -i -e '/\[::\]:80/ s/^#*/#/' /etc/nginx/sites-enabled/default
RUN sed -i -e '/\[::\]:80/ s/^#*/#/' /var/lib/dokku/plugins/nginx-vhosts/templates/nginx.conf.template
RUN sed -i -e '/\[::\]:80/ s/^#*/#/' /var/lib/dokku/plugins/nginx-vhosts/templates/nginx.ssl.conf.template

# Disable PAM
RUN sed -i 's/UsePAM yes/UsePAM no/' /etc/ssh/sshd_config

EXPOSE 22
EXPOSE 80
VOLUME ["/home/dokku"]

ADD start /start
RUN chmod 755 /start
CMD ["/start"]
