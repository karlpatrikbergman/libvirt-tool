#!/usr/bin/env bash

# Use this to create a domain to use for cloning

readonly DOMAIN="centos7_clone_source"

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