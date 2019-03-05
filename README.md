# docker_base

## Info

A minimal Docker Ubuntu 16.04/18.04 amd64 and 16.04 armhf base image (initially based on [Phusion](https://github.com/phusion/baseimage-docker)) but with:-

* [s6](http://skarnet.org/software/s6/) (via [s6-overlay](https://github.com/just-containers/s6-overlay)) instead of [runit](http://smarden.org/runit/)
* [rsyslog](http://www.rsyslog.com/) instead of [syslog-ng](https://syslog-ng.org/)

And a few extras:-

* cron
* logrotate
* [gosu](https://github.com/tianon/gosu)
* [jq](https://stedolan.github.io/jq/)
* [dumb-init](https://github.com/Yelp/dumb-init) (for running without s6, although not on armhf)
* rsync

## Notes

* s6 copies service directories from `/etc/services.d` to `/var/run/s6/services` and this path should be used for s6 commands.
* Previous images used `/etc/s6/services` for service directories. This works, however any scripts present `/etc/s6/cont-init.d` will be run at the same time as rather than before the service scripts.

## Contact

          @wamonite     - twitter
           \_______.com - web
    warren____________/ - email
