#!/bin/bash -eu

ubuntu_versions=$(curl -fsSL https://raw.githubusercontent.com/docker-library/official-images/master/library/ubuntu | grep '^Tags:' | sed -e 's/^Tags: \([^,]*\), \([^,]*\).*/\1: \2/')
grep -e 16.04 -e 18.04 -e 20.04 <<< "${ubuntu_versions}" | sort

echo "updating config.sh"
docker_image_1604=$(grep -e '16\.04' <<< "${ubuntu_versions}" | awk '{print $2}')
docker_image_1804=$(grep -e '18\.04' <<< "${ubuntu_versions}" | awk '{print $2}')
docker_image_2004=$(grep -e '20\.04' <<< "${ubuntu_versions}" | awk '{print $2}')
sed -i '' \
    -e "s/^docker_image_1604=.*$/docker_image_1604=\"${docker_image_1604}\"/" \
    -e "s/^docker_image_1804=.*$/docker_image_1804=\"${docker_image_1804}\"/" \
    -e "s/^docker_image_2004=.*$/docker_image_2004=\"${docker_image_2004}\"/" \
    build_vars.sh
