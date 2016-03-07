FROM ubuntu:vivid
MAINTAINER William Dizon <wdchromium@gmail.com>

#update apt-get repos
RUN apt-get update && apt-get upgrade -y

#update and accept all prompts
RUN apt-get install -y \
  build-essential \
  supervisor \
  rdiff-backup \
  screen \
  openjdk-8-jre-headless \
  rsync \
  git \
  curl \
  rlwrap

#install node from nodesource
RUN curl https://deb.nodesource.com/node_4.x/pool/main/n/nodejs/nodejs_4.3.1-1nodesource1~jessie1_amd64.deb > node.deb \
 && dpkg -i node.deb \
 && rm node.deb

#clean up apt for image minimalization
RUN apt-get clean \
  && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

#download mineos and npm deps
RUN mkdir /usr/games/minecraft \
  && cd /usr/games/minecraft \
  && git clone --depth=1 https://github.com/hexparrot/mineos-node.git . \
  && npm install \
  && chmod +x webui.js mineos_console.js service.js

#configure and run supervisor
RUN cp /usr/games/minecraft/init/supervisor_conf /etc/supervisor/conf.d/mineos.conf
CMD ["/usr/bin/supervisord", "-n", "-c", "/etc/supervisor/supervisord.conf"]

#entrypoint allowing for setting of mc password
COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]

EXPOSE 8443 25565
VOLUME /var/games/minecraft
