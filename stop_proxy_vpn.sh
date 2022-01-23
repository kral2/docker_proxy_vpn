#!/bin/sh

# Last update : December, 2020
# Author: cetin.ardal@oracle.com
# Description: Stop and Delete proxy_vpn container
# To be launched after updating proxy_vpn container image to force fresh container creation on next run of start_vpn_corp.sh 

script_name=$(basename "$0")
version="1.0.0"
echo "running $script_name - version $version"

CONTAINER=myvpn_corp

# attempt to stop container if it is running
if [ "$(podman ps -qa -f name=$CONTAINER)" ]; then
    echo "Stopping and deleting podman $CONTAINER container"
    podman stop $CONTAINER
    podman rm $CONTAINER
else
    echo "No $CONTAINER container found."
fi

# stop podman machine after stppoing the container
podman_machine_name=$(podman machine list --format '{{.Name}}')
podman_machine_status=$(podman machine list --format '{{.LastUp}}')

if [ "$podman_machine_status" = "Currently running" ]; then
    echo "Stopping podman machine $podman_machine_name"
    podman machine stop
else
    echo "podman machine was already stopped $podman_machine_status"
fi
