#!/usr/bin/env bash

set -eu

cd ${0%/*}
docker-compose run --rm test
