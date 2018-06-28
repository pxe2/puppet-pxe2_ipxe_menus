#!/usr/bin/env bash
mkdir -p build 
docker run -v `pwd`/build:/pxe2 pxe2/ipxe-menu-builder

