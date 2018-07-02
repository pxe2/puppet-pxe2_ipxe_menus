# A description of what this class does
#
# @summary A short summary of the purpose of this class
#
# @example
#   include pxe2_ipxe_menus::files
class pxe2_ipxe_menus::files(
  String $pxe2_path              = $pxe2_ipxe_menus::pxe2_path,
  String $pxe2_hostname          = $pxe2_ipxe_menus::pxe2_hostname,
  $default_pxeboot_option        = $pxe2_ipxe_menus::default_pxeboot_option,
  String $syslinux_version       = $pxe2_ipxe_menus::syslinux_version,
  $pxe_menu_timeout              = $pxe2_ipxe_menus::pxe_menu_timeout,
  $pxe_menu_total_timeout        = $pxe2_ipxe_menus::pxe_menu_total_timeout,
  $pxe_menu_allow_user_arguments = $pxe2_ipxe_menus::pxe_menu_allow_user_arguments,
  $puppetmaster                  = $pxe2_ipxe_menus::puppetmaster,
  $use_local_proxy               = $pxe2_ipxe_menus::use_local_proxy,
  $vnc_passwd                    = $pxe2_ipxe_menus::vnc_passwd,
){

  include ::stdlib

  # Define dictory structure on the filestem for default locations of bits.

  file{[
    $pxe2_path,
    "${pxe2_path}/syslinux",
    "${pxe2_path}/src",
    "${pxe2_path}/src/sigs",
    "${pxe2_path}/script",
    "${pxe2_path}/files",
    "${pxe2_path}/ipxe",
    "${pxe2_path}/ipxe/disks",
    "${pxe2_path}/ipxe/local",
    "${pxe2_path}/bin",
  ]:
    ensure  => directory,
    mode    => '0777',
    recurse => true,
  }
->file{"${pxe2_path}/script/secrets.tar.enc":
    ensure => file,
    mode   => '0777',
    source => "puppet:///modules/${module_name}/secrets.tar.enc",
  }
->file{"${pxe2_path}/script/prep-release.sh":
    ensure => file,
    mode   => '0777',
    content => template('pxe2_ipxe_menus/scripts/prep-release.sh.erb'),
  }
->file{"${pxe2_path}/script/generate-bsd-sigs.sh":
    ensure => file,
    mode   => '0777',
    content => template('templates/pxe.to-sigs/generate-bsd-sigs.sh.erb'),
  }
->file{"${pxe2_path}/script/generate-freedos-sigs.sh":
    ensure => file,
    mode   => '0777',
    content => template('templates/pxe.to-sigs/generate-freedos-sigs.sh.erb'),
  }
->file{"${pxe2_path}/script/generate-hypervisor-sigs.sh":
    ensure => file,
    mode   => '0777',
    content => template('templates/pxe.to-sigs/generate-hypervisor-sigs.sh.erb'),
  }
->file{"${pxe2_path}/script/generate-linux-sigs.sh":
    ensure => file,
    mode   => '0777',
    content => template('templates/pxe.to-sigs/generate-linux-sigs.sh.erb'),
  }
->file{"${pxe2_path}/script/generate-utility-sigs.sh":
    ensure => file,
    mode   => '0777',
    content => template('templates/pxe.to-sigs/generate-utility-sigs.sh.erb'),
  }
->file{"${pxe2_path}/script/decrypt-secrets.sh":
    ensure => file,
    mode   => '0777',
    content => '#! /usr/bin/env bash
openssl enc -d -aes256 -in secrets.tar.enc | tar xz -C .',
  }
->file{[
    "${pxe2_path}/docs",
    "${pxe2_path}/docs/img",
  ]:
    ensure  => directory,
    mode    => '0777',
    recurse => true,
  }
->file{"${pxe2_path}/docs/img/${pxe2_hostname}.gif":
    ensure => file,
    mode   => '0777',
    source => "puppet:///modules/${module_name}/docs/img/${pxe2_hostname}.gif",
  }
->file{"${pxe2_path}/docs/CNAME":
    ensure  => file,
    mode    => '0777',
    content => template('pxe2_ipxe_menus/docs/CNAME.erb'),
  }
->file{"${pxe2_path}/docs/boot-drac.md":
    ensure => file,
    mode   => '0777',
    source => "puppet:///modules/${module_name}/docs/boot-drac.md",
  }
->file{"${pxe2_path}/docs/boot-ilo.md":
    ensure => file,
    mode   => '0777',
    source => "puppet:///modules/${module_name}/docs/boot-ilo.md",
  }
->file{"${pxe2_path}/docs/boot-ipxe.md":
    ensure  => file,
    mode    => '0777',
    content => template('pxe2_ipxe_menus/docs/boot-ipxe.md.erb'),
  }
->file{"${pxe2_path}/docs/boot-iso.md":
    ensure  => file,
    mode    => '0777',
    content => template('pxe2_ipxe_menus/docs/boot-iso.md.erb'),
  }
->file{"${pxe2_path}/docs/boot-loaders.md":
    ensure => file,
    mode   => '0777',
    source => "puppet:///modules/${module_name}/docs/boot-loaders.md",
  }
->file{"${pxe2_path}/docs/boot-tftp.md":
    ensure  => file,
    mode    => '0777',
    content => template('pxe2_ipxe_menus/docs/boot-tftp.md.erb'),
  }
->file{"${pxe2_path}/docs/boot-usb.md":
    ensure  => file,
    mode    => '0777',
    content => template('pxe2_ipxe_menus/docs/boot-usb.md.erb'),
  }
->file{"${pxe2_path}/docs/boot-vmware.md":
    ensure  => file,
    mode    => '0777',
    content => template('pxe2_ipxe_menus/docs/boot-vmware.md.erb'),
  }
->file{[
    "${pxe2_path}/docs/contributing.md",
    "${pxe2_path}/CONTRIBUTING.md",
  ]:
    ensure  => file,
    mode    => '0777',
    content => template('pxe2_ipxe_menus/docs/contributing.md.erb'),
  }
->file{"${pxe2_path}/docs/faq.md":
    ensure  => file,
    mode    => '0777',
    content => template('pxe2_ipxe_menus/docs/faq.md.erb'),
  }
->file{"${pxe2_path}/docs/usage-digitalocean.md":
    ensure  => file,
    mode    => '0777',
    content => template('pxe2_ipxe_menus/docs/usage-digitalocean.md.erb'),
  }
->file{"${pxe2_path}/docs/usage-gce.md":
    ensure  => file,
    mode    => '0777',
    content => template('pxe2_ipxe_menus/docs/usage-gce.md.erb'),
  }
->file{"${pxe2_path}/docs/usage-packet.md":
    ensure  => file,
    mode    => '0777',
    content => template('pxe2_ipxe_menus/docs/usage-packet.md.erb'),
  }
->file{"${pxe2_path}/docs/usage-openstack.md":
    ensure  => file,
    mode    => '0777',
    content => template('pxe2_ipxe_menus/docs/usage-openstack.md.erb'),
  }
->file{"${pxe2_path}/docs/usage-rackspace.md":
    ensure  => file,
    mode    => '0777',
    content => template('pxe2_ipxe_menus/docs/usage-rackspace.md.erb'),
  }

->file{"${pxe2_path}/docs/usage-vultr.md":
    ensure  => file,
    mode    => '0777',
    content => template('pxe2_ipxe_menus/docs/usage-vultr.md.erb'),
  }


# !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
# !!! DISABLING THIS DUE TO FAILED BUILDS USING THE NETBOOT.XYZ SCRIPT !!!
# !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
#->file{"${pxe2_path}/ipxe/local/colour.h":
#    ensure  => file,
#    mode    => '0777',
#    content => '#undef COLOR_NORMAL_FG
##undef COLOR_NORMAL_BG
##undef COLOR_SELECT_FG
##undef COLOR_SELECT_BG
##undef COLOR_SEPARATOR_FG
##undef COLOR_SEPARATOR_BG
##undef COLOR_EDIT_FG
##undef COLOR_EDIT_BG
##undef COLOR_ALERT_FG
##undef COLOR_ALERT_BG
#undef COLOR_URL_FG
##undef COLOR_URL_BG
##undef COLOR_PXE_FG
##undef COLOR_PXE_BG
##define COLOR_NORMAL_FG		COLOR_CYAN
##define COLOR_NORMAL_BG		COLOR_BLACK
##define COLOR_SELECT_FG		COLOR_WHITE
##define COLOR_SELECT_BG		COLOR_BLUE
##define COLOR_SEPARATOR_FG	COLOR_WHITE
##define COLOR_SEPARATOR_BG	COLOR_BLACK
##define COLOR_EDIT_FG		COLOR_BLACK
##define COLOR_EDIT_BG		COLOR_CYAN
##define COLOR_ALERT_FG		COLOR_WHITE
##define COLOR_ALERT_BG		COLOR_RED
##define COLOR_URL_FG		COLOR_CYAN
##define COLOR_URL_BG		COLOR_BLUE
##define COLOR_PXE_FG		COLOR_BLACK
##define COLOR_PXE_BG		COLOR_WHITE
#',
#  }
# !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
# !!! DISABLING THIS DUE TO FAILED BUILDS USING THE NETBOOT.XYZ SCRIPT !!!
# !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
#->file{[
#    "${pxe2_path}/ipxe/local/general.h",
#    "${pxe2_path}/ipxe/local/general.h.efi",
#    ]:
#    ensure  => file,
#    mode    => '0777',
#    content => '#define DIGEST_CMD            /* Image crypto digest commands */
##define DOWNLOAD_PROTO_HTTPS  /* Secure Hypertext Transfer Protocol */      
##define IMAGE_COMBOOT         /* COMBOOT */
##define IMAGE_TRUST_CMD	      /* Image trust management commands */
##define NET_PROTO_IPV6        /* IPv6 protocol */
##define NSLOOKUP_CMD          /* DNS resolving command */
##define NTP_CMD               /* NTP commands */
##define PCI_CMD               /* PCI commands */
##define REBOOT_CMD            /* Reboot command */
##define TIME_CMD              /* Time commands */
##define VLAN_CMD              /* VLAN commands */
#',
#  }
#->file{"${pxe2_path}/ipxe/local/nap.h.efi":
#    ensure  => file,
#    mode    => '0777',
#    content => '/* nap.h */
#undef NAP_EFIX86
#undef NAP_EFIARM
#define NAP_NULL
#',
#  }
#
#->file{"${pxe2_path}/ipxe/local/usb.h.efi":
#    ensure  => file,
#    mode    => '0777',
#    content => '/* usb.h */
#define	USB_EFI
#',
#  }
# !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
# !!! DISABLING THIS DUE TO FAILED BUILDS USING THE NETBOOT.XYZ SCRIPT !!!
# !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

->file{"${pxe2_path}/ipxe/disks/pxe.to":
    ensure  => file,
    mode    => '0777',
    content => template('pxe2_ipxe_menus/ipxe/disks/pxe.to.erb'),
  }
->file{"${pxe2_path}/ipxe/disks/pxe.to-gce":
    ensure  => file,
    mode    => '0777',
    content => template('pxe2_ipxe_menus/ipxe/disks/pxe.to.gce.erb'),
  }
->file{"${pxe2_path}/ipxe/disks/pxe.to-packet":
    ensure  => file,
    mode    => '0777',
    content => template('pxe2_ipxe_menus/ipxe/disks/pxe.to.packet.erb'),
  }
-> file{"${pxe2_path}/src/LICENSE":
     ensure => file,
     source => "/etc/puppetlabs/code/modules/${module_name}/LICENSE",
   }
->staging::deploy{"${pxe2_path}/syslinux/syslinux-${syslinux_version}.tar.gz":
    source  => "http://mirrors.edge.kernel.org/pub/linux/utils/boot/syslinux/syslinux-${syslinux_version}.tar.gz",
    target  => "${pxe2_path}/syslinux",
    creates => [
      "${pxe2_path}/syslinux/syslinux-${syslinux_version}",
      "${pxe2_path}/syslinux/syslinux-${syslinux_version}/bios",
      "${pxe2_path}/syslinux/syslinux-${syslinux_version}/bios/memdisk",
      "${pxe2_path}/syslinux/syslinux-${syslinux_version}/bios/memdisk/memdisk",
    ],
  }
->file{"${pxe2_path}/src/memdisk":
    ensure  => file,
    mode    => '0777',
    source  => "${pxe2_path}/syslinux/syslinux-${syslinux_version}/bios/memdisk/memdisk",
    require => Staging::Deploy["${pxe2_path}/syslinux/syslinux-${syslinux_version}.tar.gz"],
  }

  # *******************************************************
  # *************** Post Install Scripts ******************
  # *******************************************************

  # Firstboot Script
  # This is script is added to the ubuntu/debian hosts via
  # the postinstall script. It will install configuration management
  # packages, the secondboot script, sets hostname and additional 
  # startup config then reboots.

->file {"${pxe2_path}/bin/firstboot":
    ensure  => file,
    mode    => '0777',
    content => template('pxe2_ipxe_menus/scripts/firstboot.erb'),
  }
  # Secondboot Script
  # Executes configuration managment ( Puppet Currently )
->file {"${pxe2_path}/bin/secondboot":
    ensure  => file,
    mode    => '0777',
    content => template('pxe2_ipxe_menus/scripts/secondboot.erb'),
  }
  # Postinstall Script
  # Installs the firstboot script and reboots the system
->file {"${pxe2_path}/bin/postinstall":
    ensure  => file,
    mode    => '0777',
    content => template('pxe2_ipxe_menus/scripts/postinstall.erb'),
  }
  # ************************************************************
  # *************** iPXE Boot Menu Entrypoint ******************
  # ************************************************************
->file {"${pxe2_path}/src/index.html":
    ensure  => file,
    mode    => '0777',
    content => template('pxe2_ipxe_menus/ipxe/disks/pxe.to.erb'),
  }
->concat {"${pxe2_path}/src/menu.ipxe":
    mode    => '0777',
  }
  concat::fragment{'menu.ipxe-default_header':
    target  => "${pxe2_path}/src/menu.ipxe",
    content => template('pxe2_ipxe_menus/01.header.menu.ipxe.erb'),
    order   => 01,
  }
  concat::fragment{'menu.ipxe-default_footer':
    target  => "${pxe2_path}/src/menu.ipxe",
    content => template('pxe2_ipxe_menus/03.tools.menu.ipxe.erb'),
    order   => 99,
  }
->concat {"${pxe2_path}/src/boot.cfg":
    mode    => '0777',
  }
  concat::fragment{'boot.cfg-default_header':
    target  => "${pxe2_path}/src/boot.cfg",
    content => template('pxe2_ipxe_menus/01.header.boot.cfg.erb'),
    order   => 01,
  }
  concat::fragment{'boot.cfg-default_footer':
    target  => "${pxe2_path}/src/boot.cfg",
    content => template('pxe2_ipxe_menus/03.footer.boot.cfg.erb'),
    order   => 99,
  }
->file {"${pxe2_path}/src/netinfo.ipxe":
    ensure => file,
    mode   => '0777',
    source => "puppet:///modules/${module_name}/netinfo.ipxe",
  }
->file {"${pxe2_path}/src/utils.ipxe":
    ensure  => file,
    mode    => '0777',
    content => template('pxe2_ipxe_menus/utils.ipxe.erb'),
  }
->concat {"${pxe2_path}/README.md":
    mode    => '0777',
  }
  concat::fragment{'README.md-default_header':
    target  => "${pxe2_path}/README.md",
    content => template('pxe2_ipxe_menus/01.header.README.md.erb'),
    order   => 01,
  }
  concat::fragment{'README.md-default_footer':
    target  => "${pxe2_path}/README.md",
    content => template('pxe2_ipxe_menus/03.footer.README.md.erb'),
    order   => 99,
  }
->file {"${pxe2_path}/docs/index.md":
    ensure => file,
    mode    => '0777',
    source => "${pxe2_path}/README.md",
  }

}
