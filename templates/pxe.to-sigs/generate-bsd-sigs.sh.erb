#!/bin/bash

# retrieve linux network installer distribution files
#wget --directory-prefix=files/freebsd boot.rackspace.com/distros/freebsd/{12.0,11.2,11.1,10.4,10.3,10.2,10.1,10.0}/FreeBSD-{12.0-RELEASE,11.2-RELEASE,11.1-RELEASE,10.4-RELEASE,10.3-RELEASE,10.2-RELEASE,10.1-RELEASE,10.0-RELEASE}-{amd64,i386}-bootonly-mfsbsd.hd
wget --directory-prefix=files/freebsd download.freebsd.org/ftp/releases/{amd64,i386}/{amd64,i386}/ISO-IMAGES/{12.0,11.2,11.1,11.0,10.4,10.3,10.2,10.1,10.0}/FreeBSD-{12.0-RELEASE,11.2-RELEASE,11.1-RELEASE,10.4-RELEASE,10.3-RELEASE,10.2-RELEASE,10.1-RELEASE,9.3-RELEASE}-{amd64,i386}-bootonly.iso
wget --directory-prefix=files/openbsd ftp.openbsd.org/pub/OpenBSD/{6.1,6.2,6.3}/{amd64,i386}/cd{61,62,63}.iso

DIR_LIST="openbsd/pub/OpenBSD/*/*/* \
          freebsd/distros/freebsd/*/*"

# Loop through and generate signatures for everything
cd files
for FILE in `ls -1 $DIR_LIST`; do
    mkdir -p ../sigs/`dirname $FILE`
    openssl cms -sign -binary -noattr -in $FILE \
    -signer ../script/certs/codesign.crt -inkey ../script/private/codesign.key -certfile ../script/certs/ca.crt -outform DER \
    -out ../sigs/$FILE.sig
    echo Generated $FILE.sig...
done
rm -rf files/*
cd ..
