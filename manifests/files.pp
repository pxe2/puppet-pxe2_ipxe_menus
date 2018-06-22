# A description of what this class does
#
# @summary A short summary of the purpose of this class
#
# @example
#   include pxe2_ipxe_menus::files
class pxe2_ipxe_menus::files (
  $pxe2_path                     = $pxe2_ipxe_menus::pxe2_path
  $default_pxeboot_option        = $quartermaster::default_pxeboot_option,
  $pxe_menu_timeout              = $quartermaster::pxe_menu_timeout,
  $pxe_menu_total_timeout        = $quartermaster::pxe_menu_total_timeout,
  $pxe_menu_allow_user_arguments = $quartermaster::pxe_menu_allow_user_arguments,
  $pxe_menu_default_graphics     = $quartermaster::pxe_menu_default_graphics,
  $puppetmaster                  = $quartermaster::puppetmaster,
  $use_local_proxy               = $quartermaster::use_local_proxy,
  $vnc_passwd                    = $quartermaster::vnc_passwd,
){

  include ::stdlib
  
  # Define dictory structure on the filestem for default locations of bits.

  file{[
    "${pxe2_path}",
    "${pxe2_path}/bin",
    "${pxe2_path}/usb",
    "${pxe2_path}/kickstart",
    "${pxe2_path}/preseed",
    "${pxe2_path}/packer",
    "${pxe2_path}/unattend.xml",
  ]:
    ensure  => directory,
    mode    => '0777',
    recurse => true,
  } ->

  # Firstboot Script
  # This is script is added to the ubuntu/debian hosts via
  # the postinstall script. It will install configuration management
  # packages, the secondboot script, sets hostname and additional 
  # startup config then reboots.

  file {"${pxe2_path}/bin/firstboot':
    ensure  => file,
    mode    => '0777',
    content => template('quartermaster/scripts/firstboot.erb'),
  } ->

  # Secondboot Script
  # Executes configuration managment ( Puppet Currently )
  file {"${pxe2_path}/bin/secondboot':
    ensure  => file,
    mode    => '0777',
    content => template('quartermaster/scripts/secondboot.erb'),
  } ->

  # Postinstall Script
  # Installs the firstboot script and reboots the system
  file {"${pxe2_path}/bin/postinstall':
    ensure  => file,
    mode    => '0777',
    content => template('quartermaster/scripts/postinstall.erb'),
  }

  concat {"${pxe2_path}/ipxe/ipxe.cfg/default':
    owner => $::tftp::username,
    group => $::tftp::username,
  }
  concat::fragment{'default_header':
    target  => "${pxe2_path}/ipxe/ipxe.cfg/default',
    content => template('pxe2_ipxe_menus/ipxe/header.erb'),
    order   => 01,
  }

  concat::fragment{'default_localboot':
    target  => "${pxe2_path}/ipxe/ipxe.cfg/default',
    content => template('pxe2_ipxe_menus/ipxe/localboot.erb'),
    order   => 01,
  }

file {"${pxe2_path}/ipxe/graphics.cfg':
    content =>"menu width 80
menu margin 10
menu passwordmargin 3
menu rows 12
menu tabmsgrow 18
menu cmdlinerow 18
menu endrow 24
menu passwordrow 11
",
  }

}
