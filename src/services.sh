#!/bin/bash -eux

script_path=$(cd $(dirname $0); pwd -P)
. "${script_path}"/env.sh

apt-get install -y --no-install-recommends cron rsyslog logrotate

cp -RTv "${script_path}"/etc/ /etc/

# remove useless cron entries
rm -f /etc/cron.daily/apt-compat
rm -f /etc/cron.daily/dpkg
rm -f /etc/cron.daily/passwd
rm -f /etc/cron.weekly/fstrim

# remove unused logrotate
rm -f /etc/logrotate.d/apt
rm -f /etc/logrotate.d/dpkg
