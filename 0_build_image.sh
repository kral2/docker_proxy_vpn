#!/bin/bash

# Last update : June, 2021
# Author: cetin.ardal@oracle.com
# Description: Build a new image and remove danglings

script_name=$(basename "$0")
version="1.1.0"
echo "running $script_name - version $version"

IMAGE=proxy_vpn
TAG="$(date +%Y.%m)"

# Generates the env.list file to be used by Docker run command in start_proxy_vpn.sh

if [ ! -f "env.list" ]; then
    read -r -p "VPN_URL: " VPN_URL
    echo "VPN_URL=$VPN_URL" > env.list
    read -r -p "VPN_USER: " VPN_USER
    echo "VPN_USER=$VPN_USER" >> env.list
    read -rs -p "VPN_PASSWORD: " VPN_PASSWORD
    echo "VPN_PASSWORD=$VPN_PASSWORD" >> env.list
    chmod 600 env.list
fi

# Build image with tag set to year.month

docker build Docker/ --tag "$IMAGE":"$TAG"

Docker_build_ERROR_CODE=$?
if [ $Docker_build_ERROR_CODE -eq 0 ]; then
    echo "Generated Image: $IMAGE:$TAG"
else
    echo "-> Error $Docker_build_ERROR_CODE"
fi

# Image cleanup - remove dangling proxy_vpn images

if [ "$(docker images --filter "dangling=true" --filter "label=name=$IMAGE" -q)" ]; then
    echo "Dang!! Will remove the last $IMAGE dangling image"
    docker rmi -f "$(docker images --filter "dangling=true" --filter "label=name=$IMAGE" -q)"
fi