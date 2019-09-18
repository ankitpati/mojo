#!/usr/bin/env bash

mydir="$(dirname "$0")/"
cd "$mydir"

test "$#" -ne 0 && args=(bash -lc "$*")

docker build --tag='mojodev-ubuntu' . && \
docker run --mount type=bind,src="$(pwd)",dst='/opt/mojo' \
    --publish 3000:3000 \
    --publish 8080:8080 \
    -it mojodev "${args[@]}"
