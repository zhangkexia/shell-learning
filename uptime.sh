#!/bin/bash
#filename: uptime.sh
#usage: sys uptime mon

IP_LIST="192.168.6.128 192.168.6.132"
USER="root"

for IP in $IP_LIST;
do
    utime=$(ssh ${USER}@${IP} uptime | awk '{ print $3 }' )
    echo $IP uptime: $utime
done
