if $virtual == 'docker' {
  include dummy_service
}

class{'pxe2_ipxe_menus': }
 # Fedora
  pxe2_ipxe_menus::linux_menu{'fedora-25-i386':}
  pxe2_ipxe_menus::linux_menu{'fedora-25-x86_64':}
  pxe2_ipxe_menus::linux_menu{'fedora-26-x86_64':}
  pxe2_ipxe_menus::linux_menu{'fedora-27-x86_64':}
  # Ubuntu
  pxe2_ipxe_menus::linux_menu{'ubuntu-12.04-amd64':}
  pxe2_ipxe_menus::linux_menu{'ubuntu-12.04-i386':}
  pxe2_ipxe_menus::linux_menu{'ubuntu-14.04-amd64':}
  pxe2_ipxe_menus::linux_menu{'ubuntu-14.04-i386':}
  pxe2_ipxe_menus::linux_menu{'ubuntu-16.04-amd64':}
  pxe2_ipxe_menus::linux_menu{'ubuntu-16.04-i386':}
  pxe2_ipxe_menus::linux_menu{'ubuntu-17.10-amd64':}
  pxe2_ipxe_menus::linux_menu{'ubuntu-17.10-i386':}
  pxe2_ipxe_menus::linux_menu{'ubuntu-18.04-i386':}
  pxe2_ipxe_menus::linux_menu{'ubuntu-18.04-amd64':}
  # Centos
  pxe2_ipxe_menus::linux_menu{'centos-6.8-i386':}
  pxe2_ipxe_menus::linux_menu{'centos-6.8-x86_64':}
  pxe2_ipxe_menus::linux_menu{'centos-6.9-i386':}
  pxe2_ipxe_menus::linux_menu{'centos-6.9-x86_64':}
  pxe2_ipxe_menus::linux_menu{'centos-7.0.1406-x86_64':}
  pxe2_ipxe_menus::linux_menu{'centos-7.1.1503-x86_64':}
  pxe2_ipxe_menus::linux_menu{'centos-7.2.1511-x86_64':}
  pxe2_ipxe_menus::linux_menu{'centos-7.3.1611-x86_64':}
  pxe2_ipxe_menus::linux_menu{'centos-7.4.1708-x86_64':}
  # CoreOS
  pxe2_ipxe_menus::linux_menu{'coreos-stable-amd64':}
  pxe2_ipxe_menus::linux_menu{'coreos-beta-amd64':}
  pxe2_ipxe_menus::linux_menu{'coreos-alpha-amd64':}
  # Scientific
  pxe2_ipxe_menus::linux_menu{'scientificlinux-6.8-i386':}
  pxe2_ipxe_menus::linux_menu{'scientificlinux-6.8-x86_64':}
  pxe2_ipxe_menus::linux_menu{'scientificlinux-6.9-i386':}
  pxe2_ipxe_menus::linux_menu{'scientificlinux-6.9-x86_64':}
  pxe2_ipxe_menus::linux_menu{'scientificlinux-7.0-x86_64':}
  pxe2_ipxe_menus::linux_menu{'scientificlinux-7.1-x86_64':}
  pxe2_ipxe_menus::linux_menu{'scientificlinux-7.2-x86_64':}
  pxe2_ipxe_menus::linux_menu{'scientificlinux-7.3-x86_64':}
  pxe2_ipxe_menus::linux_menu{'scientificlinux-7.4-x86_64':}
  # Oracle Linux
  pxe2_ipxe_menus::linux_menu{'oraclelinux-6.9-i386':}
  pxe2_ipxe_menus::linux_menu{'oraclelinux-6.9-x86_64':}
#  pxe2_ipxe_menus::linux_menu{'oraclelinux-7.3-x86_64':}
#  pxe2_ipxe_menus::linux_menu{'oraclelinux-7.4-x86_64':}
  pxe2_ipxe_menus::linux_menu{'oraclelinux-7.5-x86_64':}
  # Debian
  pxe2_ipxe_menus::linux_menu{'debian-5-i386':}
  pxe2_ipxe_menus::linux_menu{'debian-5-amd64':}
  pxe2_ipxe_menus::linux_menu{'debian-6-i386':}
  pxe2_ipxe_menus::linux_menu{'debian-6-amd64':}
  pxe2_ipxe_menus::linux_menu{'debian-7-amd64':}
  pxe2_ipxe_menus::linux_menu{'debian-7-i386':}
  pxe2_ipxe_menus::linux_menu{'debian-8-amd64':}
  pxe2_ipxe_menus::linux_menu{'debian-8-i386':}
  pxe2_ipxe_menus::linux_menu{'debian-9-amd64':}
  pxe2_ipxe_menus::linux_menu{'debian-9-i386':}
  # Kali Linux 
  # Kali Linux 
  pxe2_ipxe_menus::linux_menu{'kali-current-amd64':}
  pxe2_ipxe_menus::linux_menu{'kali-current-i386':}
# RancherOS
  pxe2_ipxe_menus::linux_menu{'rancheros-1.1.0-amd64':}
  pxe2_ipxe_menus::linux_menu{'rancheros-1.1.1-amd64':}
  pxe2_ipxe_menus::linux_menu{'rancheros-1.2.0-amd64':}
  pxe2_ipxe_menus::linux_menu{'rancheros-1.3.0-amd64':}
  pxe2_ipxe_menus::linux_menu{'rancheros-1.4.0-amd64':}
# OpenSuse
  pxe2_ipxe_menus::linux_menu{'opensuse-13.2-x86_64':}
  pxe2_ipxe_menus::linux_menu{'opensuse-42.2-x86_64':}
  pxe2_ipxe_menus::linux_menu{'opensuse-42.3-x86_64':}
