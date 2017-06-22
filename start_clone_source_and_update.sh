#!/usr/bin/env bash

. common.sh

set -o nounset # Treat unset variables as an error
export PS4='+(${BASH_SOURCE}:${LINENO}): ${FUNCNAME[0]:+${FUNCNAME[0]}(): }'
set -x

# REMEMBER:
# There must be an image "centos7_clone_source.qcow2" in the images directory (IMAGE_PATH)
# on the local node for this script to work.
#
# --import = Skip the OS installation process, and build a guest around an existing
# disk image. The device used for booting is the first device specified via
# "--disk" or "--filesystem

# Example creating domain locally:
# ./create_domain_local_copy.sh foo
#

DOMAIN=${1}

cp ${LOCAL_IMAGE_PATH}/centos7_clone_source.qcow2 ${LOCAL_IMAGE_PATH}/${DOMAIN}.qcow2

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