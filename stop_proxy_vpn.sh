#!/bin/sh

# Last update : February, 2022
# Author: cetin.ardal@oracle.com
# Description: Stop and Delete proxy_vpn container
# To be launched after updating proxy_vpn container image to force fresh container creation on next run of start_vpn_corp.sh 

script_name=$(basename "$0")
version="1.0.0"
echo "running $script_name - version $version"

CONTAINER=myvpn_corp

# attempt to stop container if it is running
if [ "$(podman ps -qa -f name=$CONTAINER)" ]; then
    echo "Stopping and deleting proxy_vpn container: $CONTAINER"
    podman stop $CONTAINER
    podman rm $CONTAINER
else
    echo "No $CONTAINER container found."
fi

# stop podman machine after stopping the container
# TODO: stop podmain machine only if proxy_vpn is the last running container
podman_machine_name=$(podman machine list --format '{{.Name}}')
podman_machine_status=$(podman machine list --format '{{.LastUp}}')

if [ "$podman_machine_status" = "Currently running" ]; then
    echo "Stopping podman machine: $podman_machine_name"
    podman machine stop
    sleep 5 # ! quickfix: need to add this arbitrary timer as podman take a few secondes to really stop the machine and we are not really checking this status ...
else
    echo "podman machine was already stopped $podman_machine_status"
fi
