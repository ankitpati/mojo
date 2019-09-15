#!/usr/bin/env bash

mydir="$(dirname "$0")/"
cd "$mydir"

docker build --tag='mojodev' . && \
docker run --mount type=bind,src="$(pwd)",dst='/opt/mojo' \
    --publish 3000:3000 \
    --publish 8080:8080 \
    -it mojodev "$@"
