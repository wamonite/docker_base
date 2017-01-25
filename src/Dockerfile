FROM ubuntu:16.04
MAINTAINER Warren Moore <warren@wamonite.com>

ADD . /tmp/build

RUN \
    /tmp/build/prepare.sh && \
    /tmp/build/install.sh && \
    /tmp/build/services.sh && \
    /tmp/build/clean.sh

ENTRYPOINT ["/init"]
