#!/bin/bash -eux

. config.sh

exec ${docker_cmd} build --rm -t "${image_name}" src
