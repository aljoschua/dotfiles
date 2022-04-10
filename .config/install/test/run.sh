#!/usr/bin/env bash

set -eu

cd ${0%/*}/..
docker run -itv $PWD:/install --rm test_install
