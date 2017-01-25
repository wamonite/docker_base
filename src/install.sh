#!/bin/bash -eux

script_path=$(cd $(dirname $0); pwd -P)
. "${script_path}"/env.sh

apt-get install -y --no-install-recommends curl less vim-tiny jq

s6_overlay_ver=1.19.1.1
s6_overlay_dest=/tmp/s6-overlay-amd64.tar.gz
curl -SLo "${s6_overlay_dest}" https://github.com/just-containers/s6-overlay/releases/download/v${s6_overlay_ver}/s6-overlay-amd64.tar.gz
tar -xzvf "${s6_overlay_dest}" -C /

dumbinit_ver=1.1.3
dumbinit_dest=/usr/local/bin/dumb-init
curl -SLo "${dumbinit_dest}" https://github.com/Yelp/dumb-init/releases/download/v${dumbinit_ver}/dumb-init_${dumbinit_ver}_amd64
chmod 755 "${dumbinit_dest}"

gosu_ver=1.10
gosu_dest=/usr/local/bin/gosu
curl -SLo "${gosu_dest}" https://github.com/tianon/gosu/releases/download/${gosu_ver}/gosu-$(dpkg --print-architecture)
chmod 755 "${gosu_dest}"
