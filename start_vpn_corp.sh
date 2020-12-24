TEST_URL=https://myintranetsite.com
MYPORT=3233
VPN_NAME="My Corp"
CONTAINER=myvpn_corp
IMAGE=vpn_corp_2020_11
LOGS_DIR=$HOME/docker_vpn_logs/squid

echo "Launching Docker container for $VPN_NAME VPN"
docker run --name $CONTAINER --privileged  -p $MYPORT:$MYPORT -v $LOGS_DIR:/var/log/squid -d $IMAGE

echo "Waiting for 5 seconds"
sleep 5

export http_proxy=localhost:$MYPORT
export https_proxy=localhost:$MYPORT
wget -q -O - $TEST_URL  >/dev/null
CR=$?
echo "CR=$CR"
while [ $CR -ne 0 ]
do
        echo "Proxy not yet available. Sleeping 3 seconds"
        sleep 3
        wget -q -O - $TEST_URL >/dev/null
	CR=$?
        echo "CR=$CR"
done

echo "Proxy is available"
