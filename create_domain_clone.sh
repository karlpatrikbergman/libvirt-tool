#!/bin/bash - 

set -o nounset # Treat unset variables as an error
export PS4='+(${BASH_SOURCE}:${LINENO}): ${FUNCNAME[0]:+${FUNCNAME[0]}(): }'
set -x

# REMEMBER:
# There must be a domain "centos7_clone_source" on the node for this script to work.

CONNECTION=${1}
DOMAIN=${2}
IMAGE_PATH=${3}
DOMAIN_CLONE_SOURCE=centos7_clone_source

virt-clone \
    --connect ${CONNECTION} \
    --original ${DOMAIN_CLONE_SOURCE} \
    --name ${DOMAIN} \
    --file ${IMAGE_PATH}/${DOMAIN}.qcow2 \
    --debug

virsh \
    -c ${CONNECTION} \
    start ${DOMAIN}