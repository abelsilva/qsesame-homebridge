FROM ubuntu:18.04
LABEL maintainer="abel.silva@gmail.com"

RUN apt-get update \
 && apt-get install -y --no-install-recommends \
            curl \
            less \
            ca-certificates \
            psmisc \
            lsb-release

RUN curl -sL https://deb.nodesource.com/setup_12.x | bash -

RUN apt-get update \
 && apt-get install -y --no-install-recommends \
            nodejs \
 && rm -rf /var/lib/apt/lists/*

RUN npm install -g --unsafe-perm homebridge homebridge-qsesame

RUN mkdir /root/.homebridge

ADD start.sh /srv/bin/start.sh
RUN chmod +x /srv/bin/start.sh

ADD config.dist.json /root/.homebridge/

VOLUME /root/.homebridge/persist

CMD ["/srv/bin/start.sh"]

