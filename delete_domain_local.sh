#!/usr/bin/env bash
. common_settings.sh
. common_local_variables.sh

# Example creating domain locally:
# ./delete_domain_local.sh foo

readonly DOMAIN=${1}

virsh -c ${LOCAL_CONNECTION} destroy ${DOMAIN}
virsh -c ${LOCAL_CONNECTION} undefine ${DOMAIN}

rm ${LOCAL_IMAGE_PATH}/${DOMAIN}.qcow2
