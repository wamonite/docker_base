#!//bin/bash -eu

s6-svwait -D /var/run/s6/services/rsyslog_tail
