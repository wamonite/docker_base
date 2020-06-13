#!/bin/bash -eux

export DEBIAN_FRONTEND=noninteractive
export DEBCONF_NONINTERACTIVE_SEEN=true

S6_VERSION=1.21.7.0
DUMBINIT_VERSION=1.2.2
DUMBINIT_CHECKSUM=37f2c1f0372a45554f1b89924fbb134fc24c3756efaedf11e07f599494e0eff9
GOSU_VERSION=1.11

######## PREPARE

# Enable Ubuntu Universe and Multiverse
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

# Install HTTPS support for APT
apt-get install -y --no-install-recommends apt-transport-https ca-certificates

# Install add-apt-repository
apt-get install -y --no-install-recommends software-properties-common

# Fix locale
apt-get install -y --no-install-recommends locales
locale-gen ${INSTALL_LANG}
update-locale LANG=${INSTALL_LANG} LANGUAGE=${INSTALL_LANGUAGE}

######## INSTALL

# gpg-agent required for gpg --import, dirmngr required for gpg --recv-keys
if [[ "${IMAGE_BASE}" != *xenial* ]]
then
    apt-get install -y --no-install-recommends gpg-agent dirmngr
    mkdir -p /root/.gnupg
    # https://github.com/inversepath/usbarmory-debian-base_image/issues/9
    echo "disable-ipv6" >> /root/.gnupg/dirmngr.conf
fi

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
if [[ "${IMAGE_BASE}" == *focal* ]]
then
    # split across two tar commands as explained in https://github.com/just-containers/s6-overlay#bin-and-sbin-are-symlinks
    tar -xzvf "${s6_overlay_dest}" -C / --exclude='./bin'
    tar -xzvf "${s6_overlay_dest}" -C /usr ./bin
else
    tar -xzvf "${s6_overlay_dest}" -C /
fi

# dumb-init
if [[ "${build_arch}" == "amd64" ]]
then
    dumbinit_dest=/usr/local/bin/dumb-init
    curl -SLo "${dumbinit_dest}" https://github.com/Yelp/dumb-init/releases/download/v${DUMBINIT_VERSION}/dumb-init_${DUMBINIT_VERSION}_${build_arch}
    echo "${DUMBINIT_CHECKSUM} ${dumbinit_dest}" | sha256sum -c -
    chmod 755 "${dumbinit_dest}"
fi

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
rm -rf /root/.gnupg
rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
rm -rf /var/log/apt/* /var/log/dpkg.log /var/log/alternatives.log /var/log/bootstrap.log /var/log/dmesg
