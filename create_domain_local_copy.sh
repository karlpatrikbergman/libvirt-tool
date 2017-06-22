#!/usr/bin/env bash
. common.sh

# Creates a new domain by first copying an existing image file
#
# --import = Skip the OS installation process, and build a guest around an existing
# disk image.

# Example creating domain locally:
# ./create_domain_local_copy.sh foo
#

readonly SCRIPT_NAME=`basename "$0"`

if [[ $# -ne 1 ]] ; then
  echo "Usage: ${SCRIPT_NAME} <domain-name>"
  exit 0
fi

DOMAIN=${1}

cp ${LOCAL_IMAGE_PATH}/${LOCAL_CLONE_SOURCE}.qcow2 ${LOCAL_IMAGE_PATH}/${DOMAIN}.qcow2

virt-install \
    --connect ${LOCAL_CONNECTION} \
    --name ${DOMAIN} \
    --ram 4096 \
    --disk ${LOCAL_IMAGE_PATH}/${DOMAIN}.qcow2,format=qcow2,bus=virtio,cache=none,size=20 \
    --vcpus 2 \
    --os-type linux \
    --os-variant rhel7 \
    --network=bridge:virbr0,model=virtio \
    --console pty,target_type=serial \
    --keymap=sv-latin1 \
    --noautoconsole \
    --import \
    --accelerate \
    --debug