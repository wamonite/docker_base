#!/bin/bash -eu

curl -fsSL https://raw.githubusercontent.com/docker-library/official-images/master/library/ubuntu | grep '^Tags:' | sed -e 's/^Tags: \([^,]*\), \([^,]*\).*/\1: \2/' | grep -e 16.04 -e 18.04 -e 20.04 | sort
