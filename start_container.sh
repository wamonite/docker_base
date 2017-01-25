#!/bin/bash -eu

. config.sh

exec ${docker_cmd} \
    run \
    --rm \
    -ti \
    --hostname "${container_name}" \
    --name "${container_name}" \
    "${image_name}" \
    bash
