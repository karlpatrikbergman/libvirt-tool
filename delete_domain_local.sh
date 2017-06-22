#!/usr/bin/env bash
. common.sh

set -o nounset # Treat unset variables as an error
export PS4='+(${BASH_SOURCE}:${LINENO}): ${FUNCNAME[0]:+${FUNCNAME[0]}(): }'
set -x

# Example creating domain locally:
# ./delete_domain_local.sh foo

readonly DOMAIN=${1}

virsh -c ${LOCAL_CONNECTION} destroy ${DOMAIN}
virsh -c ${LOCAL_CONNECTION} undefine ${DOMAIN}

rm ${LOCAL_IMAGE_PATH}/${DOMAIN}.qcow2
