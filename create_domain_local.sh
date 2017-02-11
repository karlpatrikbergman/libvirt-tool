#!/usr/bin/env bash

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
#
# My local path
# /usr/local/src/libvirt-example/images
#
# Example creating domain locally:
# ./create_domain_local.sh qemu://system foo /usr/local/src/libvirt-example/images
#
# TODO:
# - Add image source as input parameter instead

CONNECTION=${1}
DOMAIN=${2}
IMAGE_PATH=${3}

cp ${IMAGE_PATH}/centos7_clone_source.qcow2 ${IMAGE_PATH}/${DOMAIN}.qcow2

virt-install \
    --connect ${CONNECTION} \
    --name ${DOMAIN} \
    --ram 4096 \
    --disk ${IMAGE_PATH}/${DOMAIN}.qcow2,format=qcow2,bus=virtio,cache=none,size=20 \
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