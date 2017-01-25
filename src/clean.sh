#!/bin/bash -eux

script_path=$(cd $(dirname $0); pwd -P)
. "${script_path}"/env.sh

apt-get clean
rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
rm -rf /var/log/apt/* /var/log/dpkg.log /var/log/alternatives.log /var/log/bootstrap.log /var/log/dmesg
