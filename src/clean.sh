#!/bin/bash -eux

apt-get clean
rm -rf ~/.gnupg
rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
rm -rf /var/log/apt/* /var/log/dpkg.log /var/log/alternatives.log /var/log/bootstrap.log /var/log/dmesg
