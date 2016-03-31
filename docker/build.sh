#!/bin/bash

DOCKER_IMAGE_REPOSITORY_NAME=$1

if [ "x$1" == "x" ]; then
  DOCKER_IMAGE_REPOSITORY_NAME=$USER
fi

echo " "
echo "Current environment variables"
echo " "

env

echo " "
echo "Copy source and config files into the docker build context (this directory)"

rm -rf loganalyzer
mkdir loganalyzer

cp -r ../src loganalyzer/src
cp -r ../etc loganalyzer/etc

echo " "
echo "Starting docker build of $DOCKER_IMAGE_REPOSITORY_NAME/loganalyzer"
echo " "

set -x

docker build -t $DOCKER_IMAGE_REPOSITORY_NAME/loganalyzer .

set +x

echo " "
echo "Build complete"
echo " "

echo "To run:"
echo "  docker run -d --name loganalyzer -p 9977:80 -v /var/log:/mnt/log:ro $DOCKER_IMAGE_REPOSITORY_NAME/loganalyzer"
echo "  docker run -it --name loganalyzer -p 9977:80 -v /var/log:/mnt/log:ro $DOCKER_IMAGE_REPOSITORY_NAME/loganalyzer /bin/bash"
echo " "

