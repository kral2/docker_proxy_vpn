#!/bin/sh

# Last update : December, 2020
# Author: cetin.ardal@oracle.com
# Description: Stop and Delete proxy_vpn container
# To be launched after updating proxy_vpn container image to force fresh container creation on next run of start_vpn_corp.sh 

script_name=$(basename "$0")
version="1.0.0"
echo "running $script_name - version $version"

CONTAINER=myvpn_corp

if [ "$(podman ps -qa -f name=$CONTAINER)" ]; then
    echo "Stopping and deleting podman $CONTAINER container"
    podman stop $CONTAINER
    podman rm $CONTAINER
else
    echo "No $CONTAINER container found."
fi