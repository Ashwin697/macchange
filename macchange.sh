#!/bin/bash

file=vendorlist.txt

if 

if [ -f "$file" ]; then
 vendor=$(shuf -n 1 vendorlist.txt | awk '{print$3}')
 macgen=$(printf '%02x:%02x:%02x' $[RANDOM%256] $[RANDOM%256] $[RANDOM%256])
 newmac="$vendor:$macgen"
 down=`ip link set dev $1 down`
 setmac=`ip link set dev $1 address $newmac`
 up=`ip link set dev $1 up`
else
 echo "file not found downloading it from repo :- "
# wget -o vendorlist.txt link
fi

