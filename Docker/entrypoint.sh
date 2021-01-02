#!/bin/bash

# Last update : January, 2021
# Author: cetin.ardal@oracle.com
# Description: Restart Squid and open an VPN session

#restart squid
service squid stop
echo "$VPN_PASSWORD" |openconnect "$VPN_URL" -u "$VPN_USER" --passwd-on-stdin --no-dtls --background --disable-ipv6
# -N: foreground
sleep 2
squid -N
