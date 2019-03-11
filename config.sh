#!/bin/bash

export DOCKER_REPO=wamonite

container_name=base
# https://hub.docker.com/_/ubuntu
build_args_1604="--build-arg IMAGE_BASE=ubuntu:xenial-20190122"
build_args_1804="--build-arg IMAGE_BASE=ubuntu:bionic-20190204"
# https://hub.docker.com/r/balenalib/raspberrypi3-ubuntu/
build_args_1604pi="--build-arg IMAGE_BASE=balenalib/raspberrypi3-ubuntu:xenial-run-20190127"
