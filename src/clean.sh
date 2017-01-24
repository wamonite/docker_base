#!/bin/bash -eux

. $(cd $(dirname $0); pwd -P)/env.sh

apt-get clean
rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
