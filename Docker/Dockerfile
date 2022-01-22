FROM ubuntu:20.04
LABEL maintainer=kral2
LABEL name=proxy_vpn
LABEL date="2021.12.10"
LABEL version="0.2.3"

WORKDIR /app
ENV DEBIAN_FRONTEND=noninteractive
ENV LAST_UPDATED=2021-12-10
RUN apt-get update && apt-get upgrade -y && apt-get install -y \
    net-tools \
    openconnect \
    squid3 \
    dnsutils \
    && rm -rf /var/lib/apt/lists/*
COPY squid.conf /etc/squid/squid.conf
COPY entrypoint.sh ./entrypoint.sh
RUN chmod +x ./entrypoint.sh
ENTRYPOINT ./entrypoint.sh
