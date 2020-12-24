FROM ubuntu:18.04
MAINTAINER cpauliat

RUN apt-get update && apt-get upgrade -y && apt-get install -y \
        net-tools \
        openconnect \
        squid3 \
        dnsutils \
        && rm -rf /var/lib/apt/lists/*
COPY squid.conf /etc/squid/squid.conf
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT /entrypoint.sh
