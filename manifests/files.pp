# A description of what this class does
#
# @summary A short summary of the purpose of this class
#
# @example
#   include pxe2_ipxe_menus::files
class pxe2_ipxe_menus::files(
  $pxe2_path                     = $pxe2_ipxe_menus::pxe2_path,
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
    "${pxe2_path}/menu",
    "${pxe2_path}/bin",
  ]:
    ensure  => directory,
    mode    => '0777',
    recurse => true,
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
    content => '#!ipxe
# This is the entrypoint to load the pxe.to iPXE menu.

set conn_type https
chain --autofree https://pxe.to/menu.ipxe || echo HTTPS Failure! attempting HTTP...
set conn_type http
chain --autofree http://pxe.to/menu.ipxe || echo HTTPS Failure! attempting LOCALBOOT...
    ',
  }
->file {"${pxe2_path}/ipxe.cfg":
    ensure  => file,
    mode    => '0777',
    content => '#!ipxe

:global_vars
# set site name
set site_name pxe.to

# set boot domain
set boot_domain pxe.to

# set location of memdisk
set memdisk http://${boot_domain}/memdisk

# signature check enabled?
set sigs_enabled true

# image signatures check enabled?
set img_sigs_enabled true

# set location of signatures for sources
set sigs http://${boot_domain}/sigs/

# set location of latest iPXE
set ipxe_disk pxe.to-undionly.kpxe

:end
exit
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
