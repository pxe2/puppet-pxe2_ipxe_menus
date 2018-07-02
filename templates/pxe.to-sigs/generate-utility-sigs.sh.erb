#!/bin/bash

# retrieve util binaries
wget -nv --directory-prefix=files/alt_linux_rescue http://nightly.altlinux.org/p8/release/alt-p8-rescue-20180312-{i586,x86_64}.iso
wget -nv --directory-prefix=files/avg http://download.avg.com/filedir/inst/avg_arl_cdi_all_120_160420a12074.iso
wget -nv --directory-prefix=files/breakin http://www.advancedclustering.com/wp-content/uploads/2017/02/bootimage-4.26.1-53.iso
wget -nv --directory-prefix=files/clonezilla http://sourceforge.net/projects/clonezilla/files/clonezilla_live_stable/2.5.5-38/clonezilla-live-2.5.5-38-amd64.iso
wget -nv --directory-prefix=files/dban http://sourceforge.net/projects/dban/files/dban/dban-2.3.0/dban-2.3.0_i586.iso
wget -nv --directory-prefix=files/livegrml http://download.grml.org/grml64-{full,small}_2017.05.iso
wget -nv --directory-prefix=files/gparted http://sourceforge.net/projects/gparted/files/gparted-live-stable/0.31.0-1/gparted-live-0.31.0-1-amd64.iso
wget -nv --directory-prefix=files/memtest-501 https://boot.netboot.xyz/utils/memtest86-5.01.0
wget -nv --directory-prefix=files/partition-wizard http://www.partitionwizard.com/download/pwfree91-x64.iso
wget -nv --directory-prefix=files/pogostick http://pogostick.net/~pnh/ntpasswd/cd140201.zip
wget -nv --directory-prefix=files/sysrcd https://sourceforge.net/projects/netboot-xyz/files/distros/sysresccd-x86/4.8.1/{altker64,initram.igz,sysrcd.dat}
wget -nv --directory-prefix=files/supergrub https://sourceforge.net/projects/supergrub2/files/2.02s10-beta5/super_grub2_disk_2.02s10-beta5/super_grub2_disk_hybrid_2.02s10-beta5.iso
wget -nv --directory-prefix=files/ubcd http://mirror.sysadminguide.net/ubcd/ubcd538.iso
DIR_LIST="*/*"

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
