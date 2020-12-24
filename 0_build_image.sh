#!/bin/bash

# Last update : December, 2020
# Author: cetin.ardal@oracle.com
# Description: Build a new image and remove danglings

script_name=$(basename "$0")
version="1.0.0"
echo "running $script_name - version $version"

if [ ! -f "Docker/mysecret.txt" ]; then
    read -rs -p "mysecret: " mysecret
    echo "$mysecret" > Docker/mysecret.txt
    chmod 600 Docker/mysecret.txt
fi

docker build Docker/ -t proxy_vpn:"$(date +%Y.%m)"

if [ "$(docker images -f "dangling=true" -q)" ]; then
    echo "Dang!! Will remove Dangling images "
    docker rmi -f "$(docker images -f "dangling=true" -q)"
fi