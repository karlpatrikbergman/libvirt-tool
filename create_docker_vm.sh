#!/usr/bin/env bash

docker-machine --debug create -d generic \
  --generic-ip-address 172.16.15.230 \
  --generic-ssh-key ~/.ssh/id_rsa \
  --generic-ssh-user root \
  --generic-ssh-port 22 \
  pabe-test-machine