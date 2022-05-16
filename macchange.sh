#!/bin/bash

file=vendorlist.txt



if [ -f "$file" ]; then
 vendor=$(shuf -n 1 vendorlist.txt | awk '{print$3}')
 macgen=$(printf '%02x:%02x:%02x' $[RANDOM%256] $[RANDOM%256] $[RANDOM%256])
 newmac="$vendor:$macgen"
 oldmac=$(ip addr show eno1 | grep ether | awk -F" " '{print $2}')
 echo "oldaddr $oldmac"
 down=`ip link set dev $1 down`
 setmac=`ip link set dev $1 address $newmac`
 echo "newaddr $newmac"
 up=`ip link set dev $1 up`

fi


if [ ! -f "$file"  ] ; then
 echo "file not found downloading it from repo :- https://github.com/Ashwin697/macchange "
 wget https://raw.githubusercontent.com/Ashwin697/macchange/main/vendorlist.txt
 vendor=$(shuf -n 1 vendorlist.txt | awk '{print$3}')
 macgen=$(printf '%02x:%02x:%02x' $[RANDOM%256] $[RANDOM%256] $[RANDOM%256])
 newmac="$vendor:$macgen"
 oldmac=$(ip addr show $1 | grep ether | awk -F" " '{print $2}')
 echo "oldaddr $oldmac"
 down=`ip link set dev $1 down`
 setmac=`ip link set dev $1 address $newmac`
 echo "newaddr $newmac"
 up=`ip link set dev $1 up`

else

 echo "device not found"
 echo "Usage:"
 echo "-- ./macchange.sh <interface>"

fi
