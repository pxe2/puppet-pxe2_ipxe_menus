if $virtual == 'docker' {
  include dummy_service
}

class{'pxe2_ipxe_menus': }
  # Fedora
  # i386
  pxe2_ipxe_menus::linux_menu{'fedora-2-i386':}
  pxe2_ipxe_menus::linux_menu{'fedora-3-i386':}
  pxe2_ipxe_menus::linux_menu{'fedora-4-i386':}
  pxe2_ipxe_menus::linux_menu{'fedora-5-i386':}
  pxe2_ipxe_menus::linux_menu{'fedora-6-i386':}
  pxe2_ipxe_menus::linux_menu{'fedora-7-i386':}
  pxe2_ipxe_menus::linux_menu{'fedora-8-i386':}
  pxe2_ipxe_menus::linux_menu{'fedora-9-i386':}
  pxe2_ipxe_menus::linux_menu{'fedora-10-i386':}
  pxe2_ipxe_menus::linux_menu{'fedora-11-i386':}
  pxe2_ipxe_menus::linux_menu{'fedora-12-i386':}
  pxe2_ipxe_menus::linux_menu{'fedora-13-i386':}
  pxe2_ipxe_menus::linux_menu{'fedora-14-i386':}
  pxe2_ipxe_menus::linux_menu{'fedora-15-i386':}
  pxe2_ipxe_menus::linux_menu{'fedora-16-i386':}
  pxe2_ipxe_menus::linux_menu{'fedora-17-i386':}
  pxe2_ipxe_menus::linux_menu{'fedora-18-i386':}
  pxe2_ipxe_menus::linux_menu{'fedora-19-i386':}
  pxe2_ipxe_menus::linux_menu{'fedora-20-i386':}
  pxe2_ipxe_menus::linux_menu{'fedora-21-i386':}
  pxe2_ipxe_menus::linux_menu{'fedora-22-i386':}
  pxe2_ipxe_menus::linux_menu{'fedora-23-i386':}
  pxe2_ipxe_menus::linux_menu{'fedora-24-i386':}
  pxe2_ipxe_menus::linux_menu{'fedora-25-i386':}
  pxe2_ipxe_menus::linux_menu{'fedora-26-i386':}
  pxe2_ipxe_menus::linux_menu{'fedora-27-i386':}
  # Fedora
  # x86_64
  pxe2_ipxe_menus::linux_menu{'fedora-1-x86_64':}
  pxe2_ipxe_menus::linux_menu{'fedora-2-x86_64':}
  pxe2_ipxe_menus::linux_menu{'fedora-3-x86_64':}
  pxe2_ipxe_menus::linux_menu{'fedora-4-x86_64':}
  pxe2_ipxe_menus::linux_menu{'fedora-5-x86_64':}
  pxe2_ipxe_menus::linux_menu{'fedora-6-x86_64':}
  pxe2_ipxe_menus::linux_menu{'fedora-7-x86_64':}
  pxe2_ipxe_menus::linux_menu{'fedora-8-x86_64':}
  pxe2_ipxe_menus::linux_menu{'fedora-9-x86_64':}
  pxe2_ipxe_menus::linux_menu{'fedora-10-x86_64':}
  pxe2_ipxe_menus::linux_menu{'fedora-11-x86_64':}
  pxe2_ipxe_menus::linux_menu{'fedora-12-x86_64':}
  pxe2_ipxe_menus::linux_menu{'fedora-13-x86_64':}
  pxe2_ipxe_menus::linux_menu{'fedora-14-x86_64':}
  pxe2_ipxe_menus::linux_menu{'fedora-15-x86_64':}
  pxe2_ipxe_menus::linux_menu{'fedora-16-x86_64':}
  pxe2_ipxe_menus::linux_menu{'fedora-17-x86_64':}
  pxe2_ipxe_menus::linux_menu{'fedora-18-x86_64':}
  pxe2_ipxe_menus::linux_menu{'fedora-19-x86_64':}
  pxe2_ipxe_menus::linux_menu{'fedora-20-x86_64':}
  pxe2_ipxe_menus::linux_menu{'fedora-21-x86_64':}
  pxe2_ipxe_menus::linux_menu{'fedora-22-x86_64':}
  pxe2_ipxe_menus::linux_menu{'fedora-23-x86_64':}
  pxe2_ipxe_menus::linux_menu{'fedora-24-x86_64':}
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
  pxe2_ipxe_menus::linux_menu{'centos-2.1-i386':}
  pxe2_ipxe_menus::linux_menu{'centos-3.1-i386':}
  pxe2_ipxe_menus::linux_menu{'centos-3.3-i386':}
  pxe2_ipxe_menus::linux_menu{'centos-3.4-i386':}
  pxe2_ipxe_menus::linux_menu{'centos-3.5-i386':}
  pxe2_ipxe_menus::linux_menu{'centos-3.6-i386':}
  pxe2_ipxe_menus::linux_menu{'centos-3.7-i386':}
  pxe2_ipxe_menus::linux_menu{'centos-3.8-i386':}
  pxe2_ipxe_menus::linux_menu{'centos-3.9-i386':}
  pxe2_ipxe_menus::linux_menu{'centos-4.0-i386':}
  pxe2_ipxe_menus::linux_menu{'centos-4.1-i386':}
  pxe2_ipxe_menus::linux_menu{'centos-4.2-i386':}
  pxe2_ipxe_menus::linux_menu{'centos-4.3-i386':}
  pxe2_ipxe_menus::linux_menu{'centos-4.4-i386':}
  pxe2_ipxe_menus::linux_menu{'centos-4.5-i386':}
  pxe2_ipxe_menus::linux_menu{'centos-4.6-i386':}
  pxe2_ipxe_menus::linux_menu{'centos-4.7-i386':}
  pxe2_ipxe_menus::linux_menu{'centos-4.8-i386':}
  pxe2_ipxe_menus::linux_menu{'centos-4.9-i386':}
  pxe2_ipxe_menus::linux_menu{'centos-5.0-i386':}
  pxe2_ipxe_menus::linux_menu{'centos-5.1-i386':}
  pxe2_ipxe_menus::linux_menu{'centos-5.2-i386':}
  pxe2_ipxe_menus::linux_menu{'centos-5.3-i386':}
  pxe2_ipxe_menus::linux_menu{'centos-5.4-i386':}
  pxe2_ipxe_menus::linux_menu{'centos-5.5-i386':}
  pxe2_ipxe_menus::linux_menu{'centos-5.6-i386':}
  pxe2_ipxe_menus::linux_menu{'centos-5.7-i386':}
  pxe2_ipxe_menus::linux_menu{'centos-5.8-i386':}
  pxe2_ipxe_menus::linux_menu{'centos-5.9-i386':}
  pxe2_ipxe_menus::linux_menu{'centos-5.10-i386':}
  pxe2_ipxe_menus::linux_menu{'centos-5.11-i386':}
  pxe2_ipxe_menus::linux_menu{'centos-6.0-i386':}
  pxe2_ipxe_menus::linux_menu{'centos-6.1-i386':}
  pxe2_ipxe_menus::linux_menu{'centos-6.2-i386':}
  pxe2_ipxe_menus::linux_menu{'centos-6.3-i386':}
  pxe2_ipxe_menus::linux_menu{'centos-6.4-i386':}
  pxe2_ipxe_menus::linux_menu{'centos-6.5-i386':}
  pxe2_ipxe_menus::linux_menu{'centos-6.6-i386':}
  pxe2_ipxe_menus::linux_menu{'centos-6.7-i386':}
  pxe2_ipxe_menus::linux_menu{'centos-6.8-i386':}
  pxe2_ipxe_menus::linux_menu{'centos-6.9-i386':}
  pxe2_ipxe_menus::linux_menu{'centos-2.1-x86_64':}
  pxe2_ipxe_menus::linux_menu{'centos-3.1-x86_64':}
  pxe2_ipxe_menus::linux_menu{'centos-3.3-x86_64':}
  pxe2_ipxe_menus::linux_menu{'centos-3.4-x86_64':}
  pxe2_ipxe_menus::linux_menu{'centos-3.5-x86_64':}
  pxe2_ipxe_menus::linux_menu{'centos-3.6-x86_64':}
  pxe2_ipxe_menus::linux_menu{'centos-3.7-x86_64':}
  pxe2_ipxe_menus::linux_menu{'centos-3.8-x86_64':}
  pxe2_ipxe_menus::linux_menu{'centos-3.9-x86_64':}
  pxe2_ipxe_menus::linux_menu{'centos-4.0-x86_64':}
  pxe2_ipxe_menus::linux_menu{'centos-4.1-x86_64':}
  pxe2_ipxe_menus::linux_menu{'centos-4.2-x86_64':}
  pxe2_ipxe_menus::linux_menu{'centos-4.3-x86_64':}
  pxe2_ipxe_menus::linux_menu{'centos-4.4-x86_64':}
  pxe2_ipxe_menus::linux_menu{'centos-4.5-x86_64':}
  pxe2_ipxe_menus::linux_menu{'centos-4.6-x86_64':}
  pxe2_ipxe_menus::linux_menu{'centos-4.7-x86_64':}
  pxe2_ipxe_menus::linux_menu{'centos-4.8-x86_64':}
  pxe2_ipxe_menus::linux_menu{'centos-4.9-x86_64':}
  pxe2_ipxe_menus::linux_menu{'centos-5.0-x86_64':}
  pxe2_ipxe_menus::linux_menu{'centos-5.1-x86_64':}
  pxe2_ipxe_menus::linux_menu{'centos-5.2-x86_64':}
  pxe2_ipxe_menus::linux_menu{'centos-5.3-x86_64':}
  pxe2_ipxe_menus::linux_menu{'centos-5.4-x86_64':}
  pxe2_ipxe_menus::linux_menu{'centos-5.5-x86_64':}
  pxe2_ipxe_menus::linux_menu{'centos-5.6-x86_64':}
  pxe2_ipxe_menus::linux_menu{'centos-5.7-x86_64':}
  pxe2_ipxe_menus::linux_menu{'centos-5.8-x86_64':}
  pxe2_ipxe_menus::linux_menu{'centos-5.9-x86_64':}
  pxe2_ipxe_menus::linux_menu{'centos-5.10-x86_64':}
  pxe2_ipxe_menus::linux_menu{'centos-5.11-x86_64':}
  pxe2_ipxe_menus::linux_menu{'centos-6.0-x86_64':}
  pxe2_ipxe_menus::linux_menu{'centos-6.1-x86_64':}
  pxe2_ipxe_menus::linux_menu{'centos-6.2-x86_64':}
  pxe2_ipxe_menus::linux_menu{'centos-6.3-x86_64':}
  pxe2_ipxe_menus::linux_menu{'centos-6.4-x86_64':}
  pxe2_ipxe_menus::linux_menu{'centos-6.5-x86_64':}
  pxe2_ipxe_menus::linux_menu{'centos-6.6-x86_64':}
  pxe2_ipxe_menus::linux_menu{'centos-6.7-x86_64':}
  pxe2_ipxe_menus::linux_menu{'centos-6.8-x86_64':}
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
  # i386
  pxe2_ipxe_menus::linux_menu{'scientificlinux-5.0-i386':}
  pxe2_ipxe_menus::linux_menu{'scientificlinux-5.1-i386':}
  pxe2_ipxe_menus::linux_menu{'scientificlinux-5.2-i386':}
  pxe2_ipxe_menus::linux_menu{'scientificlinux-5.3-i386':}
  pxe2_ipxe_menus::linux_menu{'scientificlinux-5.4-i386':}
  pxe2_ipxe_menus::linux_menu{'scientificlinux-5.5-i386':}
  pxe2_ipxe_menus::linux_menu{'scientificlinux-5.6-i386':}
  pxe2_ipxe_menus::linux_menu{'scientificlinux-5.7-i386':}
  pxe2_ipxe_menus::linux_menu{'scientificlinux-5.8-i386':}
  pxe2_ipxe_menus::linux_menu{'scientificlinux-5.9-i386':}
  pxe2_ipxe_menus::linux_menu{'scientificlinux-5.10-i386':}
  pxe2_ipxe_menus::linux_menu{'scientificlinux-5.11-i386':}
  pxe2_ipxe_menus::linux_menu{'scientificlinux-6.0-i386':}
  pxe2_ipxe_menus::linux_menu{'scientificlinux-6.1-i386':}
  pxe2_ipxe_menus::linux_menu{'scientificlinux-6.2-i386':}
  pxe2_ipxe_menus::linux_menu{'scientificlinux-6.3-i386':}
  pxe2_ipxe_menus::linux_menu{'scientificlinux-6.4-i386':}
  pxe2_ipxe_menus::linux_menu{'scientificlinux-6.5-i386':}
  pxe2_ipxe_menus::linux_menu{'scientificlinux-6.6-i386':}
  pxe2_ipxe_menus::linux_menu{'scientificlinux-6.7-i386':}
  pxe2_ipxe_menus::linux_menu{'scientificlinux-6.8-i386':}
  pxe2_ipxe_menus::linux_menu{'scientificlinux-6.9-i386':}
  # Scientific 
  # x86_64
  pxe2_ipxe_menus::linux_menu{'scientificlinux-5.0-x86_64':}
  pxe2_ipxe_menus::linux_menu{'scientificlinux-5.1-x86_64':}
  pxe2_ipxe_menus::linux_menu{'scientificlinux-5.2-x86_64':}
  pxe2_ipxe_menus::linux_menu{'scientificlinux-5.3-x86_64':}
  pxe2_ipxe_menus::linux_menu{'scientificlinux-5.4-x86_64':}
  pxe2_ipxe_menus::linux_menu{'scientificlinux-5.5-x86_64':}
  pxe2_ipxe_menus::linux_menu{'scientificlinux-5.6-x86_64':}
  pxe2_ipxe_menus::linux_menu{'scientificlinux-5.7-x86_64':}
  pxe2_ipxe_menus::linux_menu{'scientificlinux-5.8-x86_64':}
  pxe2_ipxe_menus::linux_menu{'scientificlinux-5.9-x86_64':}
  pxe2_ipxe_menus::linux_menu{'scientificlinux-5.10-x86_64':}
  pxe2_ipxe_menus::linux_menu{'scientificlinux-5.11-x86_64':}
  pxe2_ipxe_menus::linux_menu{'scientificlinux-6.0-x86_64':}
  pxe2_ipxe_menus::linux_menu{'scientificlinux-6.1-x86_64':}
  pxe2_ipxe_menus::linux_menu{'scientificlinux-6.2-x86_64':}
  pxe2_ipxe_menus::linux_menu{'scientificlinux-6.3-x86_64':}
  pxe2_ipxe_menus::linux_menu{'scientificlinux-6.4-x86_64':}
  pxe2_ipxe_menus::linux_menu{'scientificlinux-6.5-x86_64':}
  pxe2_ipxe_menus::linux_menu{'scientificlinux-6.6-x86_64':}
  pxe2_ipxe_menus::linux_menu{'scientificlinux-6.7-x86_64':}
  pxe2_ipxe_menus::linux_menu{'scientificlinux-6.8-x86_64':}
  pxe2_ipxe_menus::linux_menu{'scientificlinux-6.9-x86_64':}
  pxe2_ipxe_menus::linux_menu{'scientificlinux-7.0-x86_64':}
  pxe2_ipxe_menus::linux_menu{'scientificlinux-7.1-x86_64':}
  pxe2_ipxe_menus::linux_menu{'scientificlinux-7.2-x86_64':}
  pxe2_ipxe_menus::linux_menu{'scientificlinux-7.3-x86_64':}
  pxe2_ipxe_menus::linux_menu{'scientificlinux-7.4-x86_64':}
  # Oracle Linux
  # i386
  pxe2_ipxe_menus::linux_menu{'oraclelinux-4.4-i386':}
  pxe2_ipxe_menus::linux_menu{'oraclelinux-4.5-i386':}
  pxe2_ipxe_menus::linux_menu{'oraclelinux-4.6-i386':}
  pxe2_ipxe_menus::linux_menu{'oraclelinux-4.7-i386':}
  pxe2_ipxe_menus::linux_menu{'oraclelinux-4.8-i386':}
  pxe2_ipxe_menus::linux_menu{'oraclelinux-5.0-i386':}
  pxe2_ipxe_menus::linux_menu{'oraclelinux-5.1-i386':}
  pxe2_ipxe_menus::linux_menu{'oraclelinux-5.2-i386':}
  pxe2_ipxe_menus::linux_menu{'oraclelinux-5.3-i386':}
  pxe2_ipxe_menus::linux_menu{'oraclelinux-5.4-i386':}
  pxe2_ipxe_menus::linux_menu{'oraclelinux-5.5-i386':}
  pxe2_ipxe_menus::linux_menu{'oraclelinux-5.6-i386':}
  pxe2_ipxe_menus::linux_menu{'oraclelinux-5.7-i386':}
  pxe2_ipxe_menus::linux_menu{'oraclelinux-5.8-i386':}
  pxe2_ipxe_menus::linux_menu{'oraclelinux-5.9-i386':}
  pxe2_ipxe_menus::linux_menu{'oraclelinux-5.10-i386':}
  pxe2_ipxe_menus::linux_menu{'oraclelinux-5.11-i386':}
  pxe2_ipxe_menus::linux_menu{'oraclelinux-6.0-i386':}
  pxe2_ipxe_menus::linux_menu{'oraclelinux-6.1-i386':}
  pxe2_ipxe_menus::linux_menu{'oraclelinux-6.2-i386':}
  pxe2_ipxe_menus::linux_menu{'oraclelinux-6.3-i386':}
  pxe2_ipxe_menus::linux_menu{'oraclelinux-6.4-i386':}
  pxe2_ipxe_menus::linux_menu{'oraclelinux-6.5-i386':}
  pxe2_ipxe_menus::linux_menu{'oraclelinux-6.6-i386':}
  pxe2_ipxe_menus::linux_menu{'oraclelinux-6.7-i386':}
  pxe2_ipxe_menus::linux_menu{'oraclelinux-6.8-i386':}
  pxe2_ipxe_menus::linux_menu{'oraclelinux-6.9-i386':}

  # Oracle Linux
  pxe2_ipxe_menus::linux_menu{'oraclelinux-4.4-x86_64':}
  pxe2_ipxe_menus::linux_menu{'oraclelinux-4.5-x86_64':}
  pxe2_ipxe_menus::linux_menu{'oraclelinux-4.6-x86_64':}
  pxe2_ipxe_menus::linux_menu{'oraclelinux-4.7-x86_64':}
  pxe2_ipxe_menus::linux_menu{'oraclelinux-4.8-x86_64':}
  pxe2_ipxe_menus::linux_menu{'oraclelinux-5.0-x86_64':}
  pxe2_ipxe_menus::linux_menu{'oraclelinux-5.1-x86_64':}
  pxe2_ipxe_menus::linux_menu{'oraclelinux-5.2-x86_64':}
  pxe2_ipxe_menus::linux_menu{'oraclelinux-5.3-x86_64':}
  pxe2_ipxe_menus::linux_menu{'oraclelinux-5.4-x86_64':}
  pxe2_ipxe_menus::linux_menu{'oraclelinux-5.5-x86_64':}
  pxe2_ipxe_menus::linux_menu{'oraclelinux-5.6-x86_64':}
  pxe2_ipxe_menus::linux_menu{'oraclelinux-5.7-x86_64':}
  pxe2_ipxe_menus::linux_menu{'oraclelinux-5.8-x86_64':}
  pxe2_ipxe_menus::linux_menu{'oraclelinux-5.9-x86_64':}
  pxe2_ipxe_menus::linux_menu{'oraclelinux-5.10-x86_64':}
  pxe2_ipxe_menus::linux_menu{'oraclelinux-5.11-x86_64':}
  pxe2_ipxe_menus::linux_menu{'oraclelinux-6.0-x86_64':}
  pxe2_ipxe_menus::linux_menu{'oraclelinux-6.1-x86_64':}
  pxe2_ipxe_menus::linux_menu{'oraclelinux-6.2-x86_64':}
  pxe2_ipxe_menus::linux_menu{'oraclelinux-6.3-x86_64':}
  pxe2_ipxe_menus::linux_menu{'oraclelinux-6.4-x86_64':}
  pxe2_ipxe_menus::linux_menu{'oraclelinux-6.5-x86_64':}
  pxe2_ipxe_menus::linux_menu{'oraclelinux-6.6-x86_64':}
  pxe2_ipxe_menus::linux_menu{'oraclelinux-6.7-x86_64':}
  pxe2_ipxe_menus::linux_menu{'oraclelinux-6.8-x86_64':}
  pxe2_ipxe_menus::linux_menu{'oraclelinux-6.9-x86_64':}
  pxe2_ipxe_menus::linux_menu{'oraclelinux-7.0-x86_64':}
  pxe2_ipxe_menus::linux_menu{'oraclelinux-7.1-x86_64':}
  pxe2_ipxe_menus::linux_menu{'oraclelinux-7.2-x86_64':}
  pxe2_ipxe_menus::linux_menu{'oraclelinux-7.3-x86_64':}
  pxe2_ipxe_menus::linux_menu{'oraclelinux-7.4-x86_64':}
  pxe2_ipxe_menus::linux_menu{'oraclelinux-7.5-x86_64':}

  # Debian
  # i386
  pxe2_ipxe_menus::linux_menu{'debian-5-i386':}
  pxe2_ipxe_menus::linux_menu{'debian-6-i386':}
  pxe2_ipxe_menus::linux_menu{'debian-7-i386':}
  pxe2_ipxe_menus::linux_menu{'debian-8-i386':}
  pxe2_ipxe_menus::linux_menu{'debian-9-i386':}
  # Debian
  # x86_64
  pxe2_ipxe_menus::linux_menu{'debian-5-amd64':}
  pxe2_ipxe_menus::linux_menu{'debian-6-amd64':}
  pxe2_ipxe_menus::linux_menu{'debian-7-amd64':}
  pxe2_ipxe_menus::linux_menu{'debian-8-amd64':}
  pxe2_ipxe_menus::linux_menu{'debian-9-amd64':}

  # Devuan
  # i386
  pxe2_ipxe_menus::linux_menu{'devuan-1.0-i386':}
  pxe2_ipxe_menus::linux_menu{'devuan-2.0-i386':}
  # Devuan
  # amd64
  pxe2_ipxe_menus::linux_menu{'devuan-1.0-amd64':}
  pxe2_ipxe_menus::linux_menu{'devuan-2.0-amd64':}


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
