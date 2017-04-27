# docker_base

## Info

A minimal Docker Ubuntu 16.04 base image based on [Phusion baseimage](https://github.com/phusion/baseimage-docker) but with:-

* [s6](http://skarnet.org/software/s6/) (via [s6-overlay](https://github.com/just-containers/s6-overlay)) instead of [runit](http://smarden.org/runit/)
* [rsyslog](http://www.rsyslog.com/) instead of [syslog-ng](https://syslog-ng.org/)

And a few extras:-

* cron
* logrotate
* [gosu](https://github.com/tianon/gosu)
* [jq](https://stedolan.github.io/jq/)
* [dumb-init](https://github.com/Yelp/dumb-init) (for running without s6)
* rsync

## Contact

          @wamonite     - twitter
           \_______.com - web
    warren____________/ - email
