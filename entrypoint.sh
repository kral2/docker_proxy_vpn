#!/bin/bash

#restart squid
service squid stop
echo "vpnpassword" |openconnect myvpnaccess.corp.com -u cpauliat_fr --authgroup=Corp-VPN --passwd-on-stdin --no-dtls --background
# -N: foreground
sleep 2
squid -N
