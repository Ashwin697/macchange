#!/bin/bash

file=vendorlist.txt

change () {

 vendor=$(shuf -n 1 vendorlist.txt | awk '{print$3}')
 macgen=$(printf '%02x:%02x:%02x' $[RANDOM%256] $[RANDOM%256] $[RANDOM%256])
 newmac="$vendor:$macgen"
 oldvend=$(cat vendorlist.txt | ip addr show $1 | grep ether | awk -F" " '{print $2}' | awk -F":" '{print $1":"$2":"$3}')
 oldvendor=$(cat vendorlist.txt | grep $oldvend | awk '{print $5}')
 newvendor=$(cat vendorlist.txt | grep $vendor | awk '{print $5}')
 oldmac=$(ip addr show $1 | grep ether | awk -F" " '{print $2}')
 echo "status  mac                vendors"
 echo "----------------------------------------"
 echo "oldaddr $oldmac  $oldvendor"
 down=`ip link set dev $1 down`
 setmac=`ip link set dev $1 address $newmac`
 echo "newaddr $newmac  $newvendor"
 up=`ip link set dev $1 up`


}

if [ "$(id -u)" != "0" ]; then
   echo "This script must be run as root" 1>&2
   exit 1



elif [ -z $1  ] || [ "$1" != "$(ip -o link show | awk -F': ' '{print $2}' | grep $1)" ] ;then

 echo "device $1 not found"
 echo "Usage:"
 echo "-- ./macchange.sh <interface>"



elif [ -f "$file" ]; then
 change $1



elif [ ! -f "$file"  ]; then
 echo "file not found downloading it from repo :- https://github.com/Ashwin697/macchange "
 wget https://raw.githubusercontent.com/Ashwin697/macchange/main/vendorlist.txt
 change $1




fi
