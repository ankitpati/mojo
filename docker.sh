#!/usr/bin/env bash

mydir="$(dirname "$0")/"
cd "$mydir"

test "$#" -ne 0 && args=(-c "$*")

docker build --tag='mojodev' . && \
docker run --mount type=bind,src="$(pwd)",dst='/opt/mojo' -it mojodev \
                                                                "${args[@]}"
