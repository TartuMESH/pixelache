#!/bin/bash

if [ $# -eq 0 ]; then
    echo "specify at least one interface or two in case of gateway!"
    exit 1
fi

if [[ $EUID -ne 0 ]]; then
    echo "sudo rights?"
    exit 2
fi

set -x

IFACE=$1
INET=$2
WAIT=10

# http://www.open-mesh.org/projects/batman-adv/wiki/Quick-start-guide

service ifplugd stop
service network-manager stop

modprobe ipv6
modprobe batman-adv

ifconfig bat0 down
batctl if del $IFACE
ifconfig $IFACE down
ifconfig $IFACE mtu 1532
iwconfig $IFACE mode ad-hoc essid PixelMESH ap 60:10:24:24:56:55 channel 1 # 60°10'24" N, 24°56'55" E
batctl if add $IFACE
ifconfig $IFACE up
ifconfig bat0 up

if [[ -z "$INET" ]]; then

    sleep $WAIT
    dhclient -v bat0

else

    brctl addbr bridge-link
    brctl addif bridge-link bat0
    brctl addif bridge-link $INET
    dhclient bridge-link
    ifconfig bridge-link
    sleep $WAIT

fi

iwconfig $IFACE
ifconfig bat0

batctl o
