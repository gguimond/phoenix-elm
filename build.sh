#!/bin/sh

REL_DIR="/c/Users/QBNL4836/phoenix-showcase/_build/prod/rel"

# Remove old releases
rm -rf _build/prod/rel/*
rm -rf "$REL_DIR/"*

# Build the image
docker build --rm -t phoenix-showcase-build -f Dockerfile.build --build-arg http_proxy=http://proxy.rd.francetelecom.fr:8080 --build-arg https_proxy=http://proxy.rd.francetelecom.fr:8080  .

# Run the container
MSYS_NO_PATHCONV=1 docker run -it --rm --name phoenix-showcase-build -v $REL_DIR:/opt/app/_build/prod/rel phoenix-showcase-build

MSYS_NO_PATHCONV=1 cp -R "$REL_DIR/." /c/Program\ Files/wamp/www/phoenix-showcase/_build/prod/rel/