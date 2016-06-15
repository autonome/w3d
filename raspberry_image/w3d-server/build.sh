##!/bin/bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
docker build -t w3d-serverbuilder .
docker run --rm -v $DIR:/opt/build/ w3d-serverbuilder
