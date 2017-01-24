#!/bin/bash

repo_name=${DOCKER_REPO:-}
container_name=base
image_name="${repo_name:+${repo_name}/}${container_name}"
docker_cmd=${DOCKER_CMD:-docker}
