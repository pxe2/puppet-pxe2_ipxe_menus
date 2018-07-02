#!/bin/bash
# Generate signatures for Linux Menus

mirror_host=mirrors.kernel.org
wget_flags="-nv -xnH --directory-prefix=files"

# retrieve linux network installer distribution files
wget ${wget_flags} dl-cdn.alpinelinux.org/alpine/v3.8/releases/x86_64/netboot/{vmlinuz-vanilla,initramfs-vanilla}
wget ${wget_flags} ${mirror_host}/archlinux/iso/2018.06.01/arch/boot/x86_64/{vmlinuz,archiso.img}
wget ${wget_flags} ${mirror_host}/centos/{7.5.1804,6.9}/os/{x86_64,i386}/images/pxeboot/{vmlinuz,initrd.img}
wget ${wget_flags} ${mirror_host}/debian/dists/{buster,jessie,wheezy,squeeze,stretch,sid}/main/installer-{amd64,i386}/current/images/netboot/debian-installer/{amd64,i386}/{linux,initrd.gz}
wget ${wget_flags} ${mirror_host}/debian/dists/{buster,jessie,wheezy,squeeze,stretch,sid}/main/installer-{amd64,i386}/current/images/netboot/gtk/debian-installer/{amd64,i386}/{linux,initrd.gz}
wget ${wget_flags} auto.mirror.devuan.org/devuan/dists/{ascii,beowulf}/main/installer-{amd64,i386}/current/images/netboot/debian-installer/{amd64,i386}/{linux,initrd.gz}
wget ${wget_flags} auto.mirror.devuan.org/devuan/dists/{ascii,beowulf}/main/installer-{amd64,i386}/current/images/netboot/gtk/debian-installer/{amd64,i386}/{linux,initrd.gz}
wget ${wget_flags} ${mirror_host}/fedora/releases/{27,28}/{Everything,Server,Workstation}/{x86_64,i386}/os/images/pxeboot/{vmlinuz,initrd.img}
wget ${wget_flags} ${mirror_host}/fedora-alt/atomic/stable/Fedora-Atomic-{28-20180515.1,27-20180419.0}/{Atomic,AtomicHost}/x86_64/os/images/pxeboot/{vmlinuz,initrd.img}
wget -nv -xnH --directory-prefix=files/ipfire https://downloads.ipfire.org/releases/ipfire-2.x/2.19-core118/images/x86_64/{vmlinuz,instroot}
wget ${wget_flags} ${mirror_host}/mageia/distrib/{6,5,4}/{x86_64,i586}/isolinux/{x86_64,i586,i386}/{vmlinuz,all.rdz}
wget ${wget_flags} ${mirror_host}/ubuntu/dists/{artful,bionic,xenial,trusty}/main/installer-{amd64,i386}/current/images/netboot/ubuntu-installer/{amd64,i386}/{linux,initrd.gz}
wget ${wget_flags} ${mirror_host}/opensuse/distribution/leap/{42.3,15.0}/repo/oss/boot/x86_64/loader/{linux,initrd}
wget -nv -xnH --directory-prefix=files/scientific http://ftp1.scientificlinux.org/linux/scientific/{7.4,7.3,6.9,6.8}/{x86_64,i386}/os/images/pxeboot/{vmlinuz,initrd.img}

# Gather a list of all downloaded variations
DIR_LIST="alpine/*/releases/*/netboot/* \
          archlinux/iso/*/arch/boot/*/* \
          centos/*/os/*/images/pxeboot/* \
          debian/dists/*/main/installer-*/current/images/netboot/debian-installer/*/* \
          debian/dists/*/main/installer-*/current/images/netboot/gtk/debian-installer/*/* \
          devuan/dists/*/main/installer-*/current/images/netboot/debian-installer/*/* \
          devuan/dists/*/main/installer-*/current/images/netboot/gtk/debian-installer/*/* \
          fedora/releases/*/*/*/os/images/pxeboot/* \
          fedora-alt/atomic/stable/*/Atomic/x86_64/os/images/pxeboot/* \
          ipfire/releases/ipfire-2.x/*/images/x86_64/* \
          mageia/distrib/*/*/isolinux/*/* \
          opensuse/distribution/leap/*/repo/oss/boot/*/loader/* \
          opensuse/distribution/*/repo/oss/boot/*/loader/* \
          scientific/linux/scientific/*/*/os/images/pxeboot/* \
          ubuntu/dists/*/main/installer-*/current/images/netboot/ubuntu-installer/*/*"

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
