#!/bin/bash - 
. common_settings.sh

# Example:
# ./create_domain_remote_clone.sh qemu+ssh://root@tnm-vm7/system pabe_test2 /var/lib/libvirt/images

readonly SCRIPT_NAME=`basename "$0"`

if [[ $# -ne 3 ]] ; then
  echo "Usage: ${SCRIPT_NAME} <qemu-ssh-connection> <domain> <image-path>"
  echo "Example: ${SCRIPT_NAME} qemu+ssh://root@tnm-vm7/system pabe_test2 /var/lib/libvirt/images"
  exit 1
fi

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