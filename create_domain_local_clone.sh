#!/bin/bash - 
. common.sh

# REMEMBER:
# There must be a domain "centos7_clone_source" in directory "/var/lib/libvirt/images" for this script to work.
#
# Example:
# ./create_domain_remote_clone.sh qemu+ssh://root@tnm-vm7/system pabe_test /var/lib/libvirt/image
#
# TODO: Add set hostname. Copied from Niclas bash script
# echo "Trying to set hostname to $name in VM"
# ping -c1 tnm-centos7 && sshpass -v -p$SSHPASSWORD ssh -v root@tnm-centos7 -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no "hostnamectl set-hostname $name && reboot" && echo "Set hostname to $name"

DOMAIN=${1}

virt-clone \
    --connect ${LOCAL_CONNECTION} \
    --original ${LOCAL_CLONE_SOURCE} \
    --name ${DOMAIN} \
    --file ${IMAGE_PATH}/${DOMAIN}.qcow2 \
    --debug

virsh \
    -c ${CONNECTION} \
    start ${DOMAIN}