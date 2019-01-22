#!/usr/bin/execlineb -P

foreground { s6-svwait -D /var/run/s6/services/rsyslog }
redirfd -w 2 /dev/null s6-svwait -D /var/run/s6/services/rsyslog_tail
