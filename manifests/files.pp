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
    "${pxe2_path}/ipxe",
    "${pxe2_path}/ipxe/disks",
    "${pxe2_path}/ipxe/local",
    "${pxe2_path}/bin",
  ]:
    ensure  => directory,
    mode    => '0777',
    recurse => true,
  }
->file{"${pxe2_path}/ipxe/local/colour.h":
    ensure  => file,
    mode    => '0777',
    content => '#undef COLOR_NORMAL_FG
#undef COLOR_NORMAL_BG
#undef COLOR_SELECT_FG
#undef COLOR_SELECT_BG
#undef COLOR_SEPARATOR_FG
#undef COLOR_SEPARATOR_BG
#undef COLOR_EDIT_FG
#undef COLOR_EDIT_BG
#undef COLOR_ALERT_FG
#undef COLOR_ALERT_BG
#undef COLOR_URL_FG
#undef COLOR_URL_BG
#undef COLOR_PXE_FG
#undef COLOR_PXE_BG
#define COLOR_NORMAL_FG		COLOR_CYAN
#define COLOR_NORMAL_BG		COLOR_BLACK
#define COLOR_SELECT_FG		COLOR_WHITE
#define COLOR_SELECT_BG		COLOR_BLUE
#define COLOR_SEPARATOR_FG	COLOR_WHITE
#define COLOR_SEPARATOR_BG	COLOR_BLACK
#define COLOR_EDIT_FG		COLOR_BLACK
#define COLOR_EDIT_BG		COLOR_CYAN
#define COLOR_ALERT_FG		COLOR_WHITE
#define COLOR_ALERT_BG		COLOR_RED
#define COLOR_URL_FG		COLOR_CYAN
#define COLOR_URL_BG		COLOR_BLUE
#define COLOR_PXE_FG		COLOR_BLACK
#define COLOR_PXE_BG		COLOR_WHITE
',
  }
->file{[
    "${pxe2_path}/ipxe/local/general.h",
    "${pxe2_path}/ipxe/local/general.h.efi",
    ]:
    ensure  => file,
    mode    => '0777',
    content => '#define DIGEST_CMD            /* Image crypto digest commands */
#define DOWNLOAD_PROTO_HTTPS  /* Secure Hypertext Transfer Protocol */      
#define IMAGE_COMBOOT         /* COMBOOT */
#define IMAGE_TRUST_CMD	      /* Image trust management commands */
#define NET_PROTO_IPV6        /* IPv6 protocol */
#define NSLOOKUP_CMD          /* DNS resolving command */
#define NTP_CMD               /* NTP commands */
#define PCI_CMD               /* PCI commands */
#define REBOOT_CMD            /* Reboot command */
#define TIME_CMD              /* Time commands */
#define VLAN_CMD              /* VLAN commands */
',
  }
->file{"${pxe2_path}/ipxe/local/nap.h.efi":
    ensure  => file,
    mode    => '0777',
    content => '/* nap.h */
#undef NAP_EFIX86
#undef NAP_EFIARM
#define NAP_NULL
',
  }

->file{"${pxe2_path}/ipxe/local/usb.h.efi":
    ensure  => file,
    mode    => '0777',
    content => '/* usb.h */
#define	USB_EFI
',
  }
->archive{"${pxe2_path}/syslinux":
    source  => "https://mirrors.edge.kernel.org/pub/linux/utils/boot/syslinux/syslinux-${syslinux_version}.tar.gz",
    target  => '/tmp',
    extract => true,
    creates => [
      "${pxe2_path}/syslinux/syslinux-${syslinux_version}",
      "${pxe2_path}/syslinux/syslinux-${syslinux_version}/bios",
      "${pxe2_path}/syslinux/syslinux-${syslinux_version}/bios/memdisk",
      "${pxe2_path}/syslinux/syslinux-${syslinux_version}/bios/memdisk/memdisk",
    ],
  }
->archive{"${pxe2_path}/ipxe/memdisk":
    source => "${pxe2_path}/syslinux/syslinux-${syslinux_version}/bios/memdisk/memdisk",
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

->file {"${pxe2_path}/ipxe/index.html":
    ensure  => file,
    mode    => '0777',
    content => "#!ipxe
# This is the entrypoint to load the pxe.to iPXE menu.

set conn_type https
chain --autofree https://${pxe2_hostname}/menu.ipxe || echo HTTPS Failure! attempting HTTP...
set conn_type http
chain --autofree http://${pxe2_hostname}/menu.ipxe || echo HTTPS Failure! attempting LOCALBOOT...
    ",
  }
->concat {"${pxe2_path}/ipxe/menu.ipxe":
    mode    => '0777',
  }
  concat::fragment{'menu.ipxe-default_header':
    target  => "${pxe2_path}/ipxe/menu.ipxe",
    content => template('pxe2_ipxe_menus/01.header.menu.ipxe.erb'),
    order   => 01,
  }
  concat::fragment{'menu.ipxe-default_footer':
    target  => "${pxe2_path}/ipxe/menu.ipxe",
    content => template('pxe2_ipxe_menus/03.tools.menu.ipxe.erb'),
    order   => 99,
  }

}
