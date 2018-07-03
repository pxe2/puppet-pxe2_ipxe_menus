#!/bin/bash
# Generate FreeDOS menu signatures

# retrieve linux network installer distribution files
wget --directory-prefix=files/freedos www.freedos.org/download/download/fd11src.iso

DIR_LIST="freedos/*"

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
