#!/bin/bash -eu

. config.sh

version="${1:-}"

if [[ -z "${version}" ]]
then
    echo "./push_image <version>"

    ${docker_cmd} images | grep "^${image_name} "

else
    if [[ "${version}" != "latest" ]]
    then
        ${docker_cmd} tag "${image_name}:latest" "${image_name}:${version}"
    fi

    ${docker_cmd} push "${image_name}:${version}"
fi
