#!/bin/bash -eux

. $(cd $(dirname $0); pwd -P)/env.sh

apt-get clean
rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
rm -rf /var/log/apt/* /var/log/dpkg.log /var/log/alternatives.log /var/log/bootstrap.log /var/log/dmesg
