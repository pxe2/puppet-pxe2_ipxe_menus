#!/usr/bin/env bash
mkdir -p build-root
docker run -v `pwd`/build-root:/pxe2 pxe2/ipxe-menu-builder

