#!/bin/bash -eux

export DEBIAN_FRONTEND=noninteractive

apt-get install -y --no-install-recommends curl less vim-tiny jq rsync

build_arch=$(dpkg --print-architecture)

s6_overlay_ver=1.20.0.0
s6_overlay_dest=/tmp/s6-overlay-${build_arch}.tar.gz
s6_overlay_sig=/tmp/s6-overlay.sig
curl -SLo "${s6_overlay_dest}" https://github.com/just-containers/s6-overlay/releases/download/v${s6_overlay_ver}/s6-overlay-${build_arch}.tar.gz
curl -SLo "${s6_overlay_sig}" https://github.com/just-containers/s6-overlay/releases/download/v${s6_overlay_ver}/s6-overlay-${build_arch}.tar.gz.sig
curl https://keybase.io/justcontainers/key.asc | gpg --import
gpg --verify "${s6_overlay_sig}" "${s6_overlay_dest}"
tar -xzvf "${s6_overlay_dest}" -C /

dumbinit_ver=1.2.0
dumbinit_dest=/usr/local/bin/dumb-init
dumbinit_checksum=81231da1cd074fdc81af62789fead8641ef3f24b6b07366a1c34e5b059faf363
curl -SLo "${dumbinit_dest}" https://github.com/Yelp/dumb-init/releases/download/v${dumbinit_ver}/dumb-init_${dumbinit_ver}_${build_arch}
echo "${dumbinit_checksum} ${dumbinit_dest}" | sha256sum -c -
chmod 755 "${dumbinit_dest}"

gosu_ver=1.10
gosu_dest=/usr/local/bin/gosu
gosu_sig=/tmp/gosu.sig
curl -SLo "${gosu_dest}" https://github.com/tianon/gosu/releases/download/${gosu_ver}/gosu-${build_arch}
curl -SLo "${gosu_sig}" https://github.com/tianon/gosu/releases/download/${gosu_ver}/gosu-${build_arch}.asc
gpg --keyserver ha.pool.sks-keyservers.net --recv-keys B42F6819007F00F88E364FD4036A9C25BF357DD4
gpg --verify "${gosu_sig}" "${gosu_dest}"
chmod 755 "${gosu_dest}"
