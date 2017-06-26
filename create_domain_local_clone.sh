#!/bin/bash - 
. common_settings.sh
. common_local_variables.sh

# Creates a new domain by cloning copying an existing domain
#
# Example:
# ./create_domain_remote_clone.sh qemu+ssh://root@tnm-vm7/system pabe_test /var/lib/libvirt/image
#

readonly SCRIPT_NAME=`basename "$0"`

if [[ $# -ne 1 ]] ; then
  echo "Usage: ${SCRIPT_NAME} <domain-name>"
  exit 0
fi

DOMAIN=${1}

virt-clone \
    --connect ${LOCAL_CONNECTION} \
    --original ${LOCAL_CLONE_SOURCE} \
    --name ${DOMAIN} \
    --file ${LOCAL_IMAGE_PATH}/${DOMAIN}.qcow2 \
    --debug

virsh \
    -c ${LOCAL_CONNECTION} \
    start ${DOMAIN}