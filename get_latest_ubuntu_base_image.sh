#!/bin/bash -eu

rm -rf /tmp/get_latest_ubuntu_base_image
mkdir /tmp/get_latest_ubuntu_base_image
cd /tmp/get_latest_ubuntu_base_image

# this is a bit slow but can't find an easier to scrape info
git clone --depth 1 git@github.com:docker-library/repo-info.git

cd repo-info/repos/ubuntu/local

echo "16.04: $(ls xenial-*.md | sed -e 's/\.md//')"
echo "18.04: $(ls bionic-*.md | sed -e 's/\.md//')"
