# pxe2_ipxe_menus

[![License](https://img.shields.io/github/license/pxe2/puppet-pxe2_ipxe_menus.svg)](./LICENSE)
[![](https://images.microbadger.com/badges/image/pxe2/ipxe-menu-builder.svg)](https://microbadger.com/images/pxe2/ipxe-menu-builder) 
[![](https://images.microbadger.com/badges/version/pxe2/ipxe-menu-builder.svg)](https://microbadger.com/images/pxe2/ipxe-menu-builder) 

## Decription
A puppet module that builds an iPXE menu infrastructure.

## Build menus

Some basic scripts are provide to build the menus into a local directory.
To build the menus from scratch:

```
git clone https://github.com/pxe2/puppet-pxe2_ipxe_menus.git
cd puppet-pxe2_ipxe_menu
rm -rf build && ./build.sh && ./menus.sh 
```
