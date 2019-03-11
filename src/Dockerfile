ARG IMAGE_BASE

FROM ${IMAGE_BASE}
LABEL maintainer="Warren Moore <warren.moore@spatialbuzz.com>"

# needs to be repeated as also used in install.sh
ARG IMAGE_BASE

ARG INSTALL_LANG=en_GB.UTF-8
ARG INSTALL_LANGUAGE=en_GB:en

# based on https://github.com/just-containers/base-without-s6

ADD install.sh /tmp/build/

# prevent initramfs updates from trying to run grub and lilo.
# https://journal.paul.querna.org/articles/2013/10/15/docker-ubuntu-on-rackspace/
# http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=594189
ENV INITRD=no

RUN /tmp/build/install.sh

ADD fs /

# copy dotfiles from /etc/skel/
RUN rsync -av /etc/skel/ /root/

# locale environment vars are usually set by PAM, but needs to be provided by env var for Docker
ENV \
    LANG=${INSTALL_LANG} \
    LANGUAGE=${INSTALL_LANGUAGE}

ENTRYPOINT ["/init"]
