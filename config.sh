#!/bin/bash

export DOCKER_REPO=wamonite

container_name=base
# https://hub.docker.com/_/ubuntu
docker_image_1604="xenial-20200326"
docker_image_1804="bionic-20200403"
docker_image_2004="focal-20200423"
build_args_1604="--build-arg IMAGE_BASE=ubuntu:${docker_image_1604}"
build_args_1804="--build-arg IMAGE_BASE=ubuntu:${docker_image_1804}"
build_args_2004="--build-arg IMAGE_BASE=ubuntu:${docker_image_2004}"
# https://hub.docker.com/r/balenalib/raspberrypi3-ubuntu/
docker_image_1604pi="xenial-run-20190127"
build_args_1604pi="--build-arg IMAGE_BASE=balenalib/raspberrypi3-ubuntu:${docker_image_1604pi}"
# TODO https://www.balena.io/docs/reference/base-images/base-images-ref/
# TODO https://hub.docker.com/r/balenalib/raspberrypi3-64-ubuntu
