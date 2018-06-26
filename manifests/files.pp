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
    "${pxe2_path}/ipxe",
    "${pxe2_path}/ipxe/disks",
    "${pxe2_path}/ipxe/local",
    "${pxe2_path}/bin",
  ]:
    ensure  => directory,
    mode    => '0777',
    recurse => true,
  }
->file{"${pxe2_path}/ipxe/local/colour.h",
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

->file {"${pxe2_path}/index.html":
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
->file {"${pxe2_path}/menu.ipxe":
    ensure  => file,
    mode    => '0777',
    content => '
#!ipxe

:start
chain --autofree boot.cfg ||
iseq ${cls} serial && goto ignore_cls ||
set cls:hex 1b:5b:4a  # ANSI clear screen sequence - "^[[J"
set cls ${cls:string}
:ignore_cls

:version_check
set latest_version 1.04
echo ${cls}
iseq ${version} ${latest_version} && goto version_up2date ||
echo
echo Updated version of pxe.to is available:
echo
echo Running version.....${version}
echo Updated version.....${latest_version}
echo
echo Please download the latest version from pxe.to.
echo
echo Attempting to chain to latest version...
chain --autofree http://${boot_domain}/ipxe/${ipxe_disk} ||
:version_up2date

isset ${arch} && goto skip_arch_detect ||
cpuid --ext 29 && set arch x86_64 || set arch i386
iseq ${buildarch} arm64 && set arch arm64 ||
:skip_arch_detect
isset ${menu} && goto ${menu} ||

isset ${ip} || dhcp || echo DHCP failed

:main_menu
clear menu
set space:hex 20:20
set space ${space:string}
iseq ${arch} x86_64 && set arch_a amd64 || set arch_a ${arch}
menu ${site_name}
item --gap Default:
item local ${space} Boot from local hdd
item --gap Distributions:
iseq ${menu_linux} 1 && item linux ${space} Linux Installs ||
iseq ${menu_bsd} 1 && item bsd ${space} BSD Installs ||
iseq ${menu_freedos} 1 && item freedos ${space} FreeDOS || 
iseq ${menu_hypervisor} 1 && item hypervisor ${space} Hypervisor Installs ||
iseq ${menu_live} 1 && item live ${space} Live Boot ||
iseq ${menu_security} 1 && item security ${space} Security Related ||
iseq ${menu_windows} 1 && item windows ${space} Windows ||
item --gap Tools:
iseq ${menu_utils} 1 && item utils ${space} Utilities ||
iseq ${arch} x86_64 && set bits 64 || set bits 32
item changebits ${space} Architecture: ${arch} (${bits}bit)
item shell ${space} iPXE shell
item netinfo ${space} Network card info
item --gap Signature Checks:
item sig_check ${space} pxe.to [ enabled: ${sigs_enabled} ]
item img_sigs_check ${space} Images [ enabled: ${img_sigs_enabled} ]
isset ${github_user} && item --gap Custom Menu: ||
isset ${github_user} && item pxe2-custom ${space} ${github_user}'s Custom Menu ||
isset ${menu} && set timeout 0 || set timeout 300000
choose --timeout ${timeout} --default ${menu} menu || goto local
echo ${cls}
goto ${menu} ||
iseq ${sigs_enabled} true && goto verify_sigs || goto change_menu

:verify_sigs
imgverify ${menu}.ipxe ${sigs}${menu}.ipxe.sig || goto error
goto change_menu

:change_menu
chain ${menu}.ipxe || goto error
goto main_menu

:error
echo Error occured, press any key to return to menu ...
prompt
goto main_menu

:local
echo Booting from local disks ...
exit 0

:shell
echo Type "exit" to return to menu.
set menu main_menu
shell
goto main_menu

:changebits
iseq ${arch} x86_64 && set arch i386 || set arch x86_64
goto main_menu

:sig_check
iseq ${sigs_enabled} true && set sigs_enabled false || set sigs_enabled true
goto main_menu

:img_sigs_check
iseq ${img_sigs_enabled} true && set img_sigs_enabled false || set img_sigs_enabled true
goto main_menu

:pxe2-custom
chain https://raw.githubusercontent.com/${github_user}/pxe.to-custom/master/custom.ipxe || goto error
goto main_menu
',
  }
->concat {"${pxe2_path}/ipxe/menu.ipxe":
    mode    => '0777',
  }
  concat::fragment{'default_header':
    target  => "${pxe2_path}/ipxe/menu.ipxe",
    content => template('pxe2_ipxe_menus/ipxe/01.header.ipxe.erb'),
    order   => 01,
  }
  concat::fragment{'install_menu_header':
    target  => "${pxe2_path}/ipxe/menu.ipxe",
    content => template('pxe2_ipxe_menus/ipxe/01.header.os_menu.ipxe.erb'),
    order   => 02,
  }
  concat::fragment{'default_footer':
    target  => "${pxe2_path}/ipxe/menu.ipxe",
    content => template('pxe2_ipxe_menus/ipxe/04.body.adv_opts_menu.ipxe.erb'),
    order   => 99,
  }

#  concat::fragment{'default_localboot':
#    target  => "${pxe2_path}/ipxe/ipxe.cfg/default",
#    content => template('pxe2_ipxe_menus/ipxe/localboot.erb'),
#    order   => 01,
# }

}
