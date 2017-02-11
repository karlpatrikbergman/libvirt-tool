#!/usr/bin/env bash

set -o nounset # Treat unset variables as an error
export PS4='+(${BASH_SOURCE}:${LINENO}): ${FUNCNAME[0]:+${FUNCNAME[0]}(): }'
set -x

# TODO: Make ssh host dynamic

# Example:
# ./get_domain_ip_address.sh qemu+ssh://root@tnm-vm7/system centos-shilpa 172.16.15.0/24 br0

CONNECTION=${1}
DOMAIN=${2}
NETWORK=${3}
INTERFACE=${4}

for MAC in `virsh -c ${CONNECTION} domiflist ${DOMAIN} | grep -o -E "([0-9a-f]{2}:){5}([0-9a-f]{2})"` ;
    do ssh root@tnm-vm7 "arp-scan -I ${INTERFACE} ${NETWORK}" | grep ${MAC}  | grep -o -P "^\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}";
done