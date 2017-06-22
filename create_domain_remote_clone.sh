#!/bin/bash - 

set -o nounset # Treat unset variables as an error
export PS4='+(${BASH_SOURCE}:${LINENO}): ${FUNCNAME[0]:+${FUNCNAME[0]}(): }'
set -x

# REMEMBER:
# There must be a domain "centos7_clone_source" in directory "/var/lib/libvirt/images" on the node for this script to
# work.
#
# Example:
# ./create_domain_clone.sh qemu+ssh://root@tnm-vm7/system pabe_test /var/lib/libvirt/image
#
# TODO: Add set hostname. Copied from Niclas bash script
# echo "Trying to set hostname to $name in VM"
# ping -c1 tnm-centos7 && sshpass -v -p$SSHPASSWORD ssh -v root@tnm-centos7 -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no "hostnamectl set-hostname $name && reboot" && echo "Set hostname to $name"



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