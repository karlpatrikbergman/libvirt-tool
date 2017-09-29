#!/usr/bin/env bash

set -o nounset # Treat unset variables as an error
export PS4='+(${BASH_SOURCE}:${LINENO}): ${FUNCNAME[0]:+${FUNCNAME[0]}(): }'
set -x
#set -e # Quit on error