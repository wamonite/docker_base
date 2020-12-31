#!/bin/bash

export DOCKER_REPO=wamonite

container_name=base

source build_vars.sh

build_args_1604="--build-arg IMAGE_BASE=ubuntu:${docker_image_1604}"
build_args_1804="--build-arg IMAGE_BASE=ubuntu:${docker_image_1804}"
build_args_2004="--build-arg IMAGE_BASE=ubuntu:${docker_image_2004}"
build_args_1604pi="--build-arg IMAGE_BASE=balenalib/raspberrypi3-ubuntu:${docker_image_1604pi}"
