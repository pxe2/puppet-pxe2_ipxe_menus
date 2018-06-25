#!/usr/bin/env bash
set -ex
# SET THE FOLLOWING VARIABLES
# docker hub username
USERNAME=pxe2
# image name
IMAGE=puppet-pxe2_ipxe_menus
VERSION=`cat VERSION`
export USERNAME
export IMAGE
export VERSION
docker-compose build --no-cache --force-rm
