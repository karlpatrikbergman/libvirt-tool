#!/usr/bin/env bash
. common_settings.sh

# Example:
# ./create_domain_remote_copy.sh qemu+ssh://root@tnm-vm7/system pabe_test2 /var/lib/libvirt/images

readonly SCRIPT_NAME=`basename "$0"`

if [[ $# -ne 3 ]] ; then
  echo "Usage: ${SCRIPT_NAME} <qemu-ssh-connection> <domain> <image-path>"
  echo "Example: ${SCRIPT_NAME} qemu+ssh://root@tnm-vm7/system pabe_test2 /var/lib/libvirt/images"
  exit 1
fi

CONNECTION=${1}
DOMAIN=${2}
IMAGE_PATH=${3}
DOMAIN_IMG_SRC=centos7_img_source.qcow2

ssh root@tnm-vm7 "cp ${IMAGE_PATH}/${DOMAIN_IMG_SRC} ${IMAGE_PATH}/${DOMAIN}.qcow2"

virt-install \
    --connect ${CONNECTION} \
    --name ${DOMAIN} \
    --ram 4096 \
    --disk ${IMAGE_PATH}/${DOMAIN}.qcow2,format=qcow2,bus=virtio,cache=none,size=20 \
    --vcpus 2 \
    --os-type linux \
    --os-variant rhel7 \
    --network=bridge:br0,model=virtio \
    --console pty,target_type=serial \
    --keymap=sv-latin1 \
    --noautoconsole \
    --import \
    --accelerate \
    --debug