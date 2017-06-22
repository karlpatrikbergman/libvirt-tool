#!/usr/bin/env bash
. common.sh

# Example:
# ./get_domain_ip_address.sh qemu+ssh://root@tnm-vm7/system centos-shilpa 172.16.15.0/24 br0

#readonly SCRIPT_NAME=`basename "$0"`
#
#if [[ $# -ne 1 ]] ; then
#  echo "Usage: ${SCRIPT_NAME} <domain-name>"
#  exit 0
#fi
#
#DOMAIN=${1}
#NETWORK="192.168.122.0/24"
#INTERFACE="virbr0"
#
#for MAC in `virsh -c ${LOCAL_CONNECTION} domiflist ${DOMAIN} | grep -o -E "([0-9a-f]{2}:){5}([0-9a-f]{2})"` ;
#    do arp-scan -I ${INTERFACE} ${NETWORK} | grep ${MAC}  | grep -o -P "^\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}";
#done

arp-scan -I virbr0 192.168.122.0/24 | grep "52:54:00:86:07:86"  | grep -o -P "^\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}";