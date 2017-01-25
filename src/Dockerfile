FROM ubuntu:16.04
MAINTAINER Warren Moore <warren@wamonite.com>

# like https://github.com/phusion/baseimage-docker but with s6 and rsyslog

ADD . /tmp/build

RUN \
    /tmp/build/prepare.sh && \
    /tmp/build/install.sh && \
    /tmp/build/services.sh && \
    /tmp/build/clean.sh

ENTRYPOINT ["/init"]
