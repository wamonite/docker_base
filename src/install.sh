#!/bin/bash -eux

export DEBIAN_FRONTEND=noninteractive

BASE_LOCALE=en_GB
BASE_LANGUAGE=en_GB.UTF-8
S6_VERSION=1.20.0.0
DUMBINIT_VERSION=1.2.0
DUMBINIT_CHECKSUM=81231da1cd074fdc81af62789fead8641ef3f24b6b07366a1c34e5b059faf363
GOSU_VERSION=1.10

######## PREPARE

# Enable Ubuntu Universe and Multiverse.
sed -i 's/^#\s*\(deb.*universe\)$/\1/g' /etc/apt/sources.list
sed -i 's/^#\s*\(deb.*multiverse\)$/\1/g' /etc/apt/sources.list
apt-get update

# Fix some issues with APT packages (https://github.com/dotcloud/docker/issues/1024)
dpkg-divert --local --rename --add /sbin/initctl
ln -sf /bin/true /sbin/initctl

# Replace the 'ischroot' tool to make it always return true.
# Prevent initscripts updates from breaking /dev/shm.
# https://journal.paul.querna.org/articles/2013/10/15/docker-ubuntu-on-rackspace/
# https://bugs.launchpad.net/launchpad/+bug/974584
dpkg-divert --local --rename --add /usr/bin/ischroot
ln -sf /bin/true /usr/bin/ischroot

# Install HTTPS support for APT.
apt-get install -y --no-install-recommends apt-transport-https ca-certificates

# Install add-apt-repository
apt-get install -y --no-install-recommends software-properties-common

# Upgrade all packages.
apt-get dist-upgrade -y --no-install-recommends

# Fix locale.
apt-get install -y --no-install-recommends language-pack-en
locale-gen ${BASE_LOCALE}
update-locale LANG=${BASE_LANGUAGE} LC_CTYPE=${BASE_LANGUAGE}

######## INSTALL

# extra packages
apt-get install -y --no-install-recommends curl less vim-tiny jq rsync vim

build_arch=$(dpkg --print-architecture)

# s6
s6_overlay_dest=/tmp/s6-overlay-${build_arch}.tar.gz
s6_overlay_sig=/tmp/s6-overlay.sig
curl -SLo "${s6_overlay_dest}" https://github.com/just-containers/s6-overlay/releases/download/v${S6_VERSION}/s6-overlay-${build_arch}.tar.gz
curl -SLo "${s6_overlay_sig}" https://github.com/just-containers/s6-overlay/releases/download/v${S6_VERSION}/s6-overlay-${build_arch}.tar.gz.sig
curl https://keybase.io/justcontainers/key.asc | gpg --import
gpg --verify "${s6_overlay_sig}" "${s6_overlay_dest}"
tar -xzvf "${s6_overlay_dest}" -C /

# dumb-init
dumbinit_dest=/usr/local/bin/dumb-init
curl -SLo "${dumbinit_dest}" https://github.com/Yelp/dumb-init/releases/download/v${DUMBINIT_VERSION}/dumb-init_${DUMBINIT_VERSION}_${build_arch}
echo "${DUMBINIT_CHECKSUM} ${dumbinit_dest}" | sha256sum -c -
chmod 755 "${dumbinit_dest}"

# gosu
gosu_dest=/usr/local/bin/gosu
gosu_sig=/tmp/gosu.sig
curl -SLo "${gosu_dest}" https://github.com/tianon/gosu/releases/download/${GOSU_VERSION}/gosu-${build_arch}
curl -SLo "${gosu_sig}" https://github.com/tianon/gosu/releases/download/${GOSU_VERSION}/gosu-${build_arch}.asc
gpg --keyserver ha.pool.sks-keyservers.net --recv-keys B42F6819007F00F88E364FD4036A9C25BF357DD4
gpg --verify "${gosu_sig}" "${gosu_dest}"
chmod 755 "${gosu_dest}"

######## SERVICES

apt-get install -y --no-install-recommends cron rsyslog logrotate

# remove useless cron entries
rm -f /etc/cron.daily/apt-compat
rm -f /etc/cron.daily/dpkg
rm -f /etc/cron.daily/passwd
rm -f /etc/cron.weekly/fstrim

# remove unused logrotate
rm -f /etc/logrotate.d/apt
rm -f /etc/logrotate.d/dpkg

######## CLEAN

apt-get clean
rm -rf ~/.gnupg
rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
rm -rf /var/log/apt/* /var/log/dpkg.log /var/log/alternatives.log /var/log/bootstrap.log /var/log/dmesg
