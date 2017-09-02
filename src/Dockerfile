FROM ubuntu:16.04
MAINTAINER Warren Moore <warren@wamonite.com>

# based on https://github.com/just-containers/base-without-s6

ADD . /tmp/build

# prevent initramfs updates from trying to run grub and lilo.
# https://journal.paul.querna.org/articles/2013/10/15/docker-ubuntu-on-rackspace/
# http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=594189
ENV INITRD=no

RUN \
    /tmp/build/prepare.sh && \
    /tmp/build/install.sh && \
    /tmp/build/services.sh && \
    /tmp/build/clean.sh

ENV \
    LANG=en_GB.UTF-8 \
    LANGUAGE=en_GB:en \
    LC_CTYPE=en_GB.UTF-8

ENTRYPOINT ["/init"]
