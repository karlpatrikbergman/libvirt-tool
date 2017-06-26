#!/usr/bin/env bash
. common_settings.sh
./check_if_root.sh

# Prerequisites:
# arp-scan must be installed, emerge net-analyzer/arp-scan
#
# Example:
# sudo ./get_domain_ip_address_local.sh foo

readonly SCRIPT_NAME=`basename "$0"`

if [[ $# -ne 1 ]] ; then
  echo "Usage: ${SCRIPT_NAME} <domain-name>"
  exit 0
fi

DOMAIN=${1}
NETWORK="192.168.122.0/24"
INTERFACE="virbr0"

for MAC in `virsh -c ${LOCAL_CONNECTION} domiflist ${DOMAIN} | grep -o -E "([0-9a-f]{2}:){5}([0-9a-f]{2})"` ;
    do arp-scan -I ${INTERFACE} ${NETWORK} | grep ${MAC}  | grep -o -P "^\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}";
done