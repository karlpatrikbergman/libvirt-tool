#!/usr/bin/env bash
set -o nounset # Treat unset variables as an error
#export PS4='+(${BASH_SOURCE}:${LINENO}): ${FUNCNAME[0]:+${FUNCNAME[0]}(): }'
#set -x

## Please feel free to add functions for other hosts running kvm (tnm-vmX)

get_ip_address_of_vm() {
    if [[ $# -ne 4 ]] ; then
        printf "Usage: ${FUNCNAME[0]} <user@host> <domain-name> <network> <interface>\n"
        printf "Example: ${FUNCNAME[0]} root@tnm-vm7 centos-jodo 172.16.15.0/24 br0\n"
        return 1
    fi

    local readonly USER_AT_HOST="${1}"
    local readonly DOMAIN="${2}"
    local readonly NETWORK="${3}"
    local readonly INTERFACE="${4}"
    local readonly CONNECTION="qemu+ssh://${USER_AT_HOST}/system"

    local IP_ADDRESS
    for MAC in `virsh -c ${CONNECTION} domiflist ${DOMAIN} | grep -o -E "([0-9a-f]{2}:){5}([0-9a-f]{2})"` ; do
        IP_ADDRESS=$(ssh ${USER_AT_HOST} "arp-scan -I ${INTERFACE} ${NETWORK}" | grep ${MAC}  | grep -o -P "^\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}")
        echo "${IP_ADDRESS}"
    done
}

get_ip_address_of_vm_on_tnm_vm7() {
    if [[ $# -ne 1 ]] ; then
        printf "Usage: ${FUNCNAME[0]} <domain-name>\n"
        printf "Example: ${FUNCNAME[0]} centos-jodo\n"
        return 1
    fi

    local readonly DOMAIN_NAME="${1}"
    local readonly IP_ADDRESS=$(get_ip_address_of_vm root@tnm-vm7 ${DOMAIN_NAME} 172.16.15.0/24 br0)
    echo "${IP_ADDRESS}"
}

# <user@host>               A valid user and a host running a hypervisor
# <domain-clone-source>     Name of an existing domain on the host. The domain must not running and the domain image file
#                           must be in folder <image-path>
# <domain-name>             The name of the new domain
# <image-path>              The path to a directory on the host where domain images are stored
create_domain_remote() {
    if [[ $# -ne 4 ]] ; then
        printf "Usage: ${FUNCNAME[0]} <user@host> <domain-clone-source> <domain-name> <image-path>\n"
        printf "Example: ${FUNCNAME[0]} root@tnm-vm7 centos7_clone_source centos-jodo /var/lib/libvirt/images\n"
        return 1
    fi

    local readonly USER_AT_HOST="${1}"
    local readonly DOMAIN_CLONE_SOURCE="${2}"
    local readonly DOMAIN_NAME="${3}"
    local readonly IMAGE_PATH="${4}"
    local readonly CONNECTION="qemu+ssh://${USER_AT_HOST}/system"

    virt-clone \
        --connect ${CONNECTION} \
        --original ${DOMAIN_CLONE_SOURCE} \
        --name ${DOMAIN_NAME} \
        --file ${IMAGE_PATH}/${DOMAIN_NAME}.qcow2 \
        --debug

    virsh \
        -c ${CONNECTION} \
        start ${DOMAIN_NAME}
}

# tnm-vm7 is a physical machine
create_domain_on_tnm_vm7() {
    if [[ $# -ne 1 ]] ; then
        printf "Usage: ${FUNCNAME[0]} <domain-name>\n"
        printf "Example: ${FUNCNAME[0]} centos-jodo\n"
        return 1
    fi

    local readonly DOMAIN_NAME="${1}"
    local readonly USER_AT_HOST="root@tnm-vm7"
    local readonly IMAGE_PATH="/var/lib/libvirt/images"
    local readonly DOMAIN_CLONE_SOURCE="centos7_clone_source"

    create_domain_remote ${USER_AT_HOST} ${DOMAIN_CLONE_SOURCE} ${DOMAIN_NAME} ${IMAGE_PATH}
}


delete_domain_remote() {
     if [[ $# -ne 3 ]] ; then
        printf "Usage: ${FUNCNAME[0]} <user@host> <domain-name> <image-path>\n"
        printf "Example: ${FUNCNAME[0]} root@tnm-vm7 centos-jodo /var/lib/libvirt/images\n"
        return 1
    fi

    local readonly USER_AT_HOST="${1}"
    local readonly DOMAIN_NAME="${2}"
    local readonly IMAGE_PATH="${3}"
    local readonly CONNECTION="qemu+ssh://${USER_AT_HOST}/system"

    virsh -c ${CONNECTION} destroy ${DOMAIN_NAME}
    virsh -c ${CONNECTION} undefine ${DOMAIN_NAME}
    ssh ${USER_AT_HOST} "rm -f ${IMAGE_PATH}/${DOMAIN_NAME}.qcow2"
}

delete_domain_on_tnm_vm7() {
    if [[ $# -ne 1 ]] ; then
        printf "Usage: ${FUNCNAME[0]} <domain-name>\n"
        printf "Example: ${FUNCNAME[0]} centos-jodo\n"
        return 1
    fi

    local readonly DOMAIN_NAME="${1}"
    local readonly USER_AT_HOST="root@tnm-vm7"
    local readonly IMAGE_PATH="/var/lib/libvirt/images"

    delete_domain_remote ${USER_AT_HOST} ${DOMAIN_NAME}} ${IMAGE_PATH}
}

