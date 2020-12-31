#!/bin/bash -eu

source build_vars.sh

./build_image_1604.sh
echo y | ./push_image.sh "${docker_image_1604}-1"
./build_image_1804.sh
echo y | ./push_image.sh "${docker_image_1804}-1"
./build_image_2004.sh
echo y | ./push_image.sh "${docker_image_2004}-1"
