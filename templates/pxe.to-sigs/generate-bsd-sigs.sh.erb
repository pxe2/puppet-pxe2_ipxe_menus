#!/bin/bash

# retrieve linux network installer distribution files
wget --directory-prefix=files/freebsd boot.rackspace.com/distros/freebsd/{10.2,10.1,10.0}/FreeBSD-{10.2-RELEASE,10.1-RELEASE,10.0-RELEASE}-{amd64,i386}-bootonly-mfsbsd.hd
wget --directory-prefix=files/openbsd ftp.openbsd.org/pub/OpenBSD/{5.8,5.7}/{amd64,i386}/cd{58,57}.iso

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
