#!/bin/bash -eux

. $(cd $(dirname $0); pwd -P)/env.sh

apt-get install -y --no-install-recommends cron rsyslog logrotate

cp -RTv /tmp/build/s6/ /etc/s6/

# remove useless cron entries
rm -f /etc/cron.daily/apt-compat
rm -f /etc/cron.daily/dpkg
rm -f /etc/cron.daily/passwd
rm -f /etc/cron.weekly/fstrim

# remove unused logrotate
rm -f /etc/logrotate.d/apt
rm -f /etc/logrotate.d/dpkg
