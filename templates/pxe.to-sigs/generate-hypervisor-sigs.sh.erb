#!/bin/bash

mirror_host=mirrors.kernel.org
wget_flags="-xnH --directory-prefix=files"

# retrieve hypervisor distribution files
wget -xnH --directory-prefix=files/xenserver/ downloadns.citrix.com.edgesuite.net/11419/pxe/release/{6.5.0,7.0.0}/boot/{xen,vmlinuz}
wget -xnH --directory-prefix=files/xenserver/ downloadns.citrix.com.edgesuite.net/11419/pxe/release/{6.5.0,7.0.0}/install.img

DIR_LIST="xenserver/11419/pxe/release/*/boot/* \
          xenserver/11419/pxe/release/*/install.img"

# Loop through and generate signatures for everything
cd files
for FILE in `ls -1 $DIR_LIST`; do
    mkdir -p ../sigs/`dirname $FILE`
    openssl cms -sign -binary -noattr -in $FILE \
    -signer ../certs/codesign.crt -inkey ../certs/codesign.key -certfile ../certs/ca-netboot-xyz.crt -outform DER \
    -out ../sigs/$FILE.sig
    echo Generated $FILE.sig...
done
rm -rf files/*
cd ..
