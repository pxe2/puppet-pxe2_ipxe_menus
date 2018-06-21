# A description of what this class does
#
# @summary A short summary of the purpose of this class
#
# @example
#   include pxe2_ipxe_menus::files
class pxe2_ipxe_menus::files (
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
    '/srv/quartermaster',
    '/srv/quartermaster/bin',
    '/srv/quartermaster/iso',
    '/srv/quartermaster/images',
    '/srv/quartermaster/logs',
    '/srv/quartermaster/usb',
    '/srv/quartermaster/kickstart',
    '/srv/quartermaster/preseed',
    '/srv/quartermaster/packer',
    '/srv/quartermaster/ipxe',
    '/srv/quartermaster/ipxe/boot',
    '/srv/quartermaster/unattend.xml',
    '/srv/quartermaster/microsoft',
    '/srv/quartermaster/microsoft/iso',
    '/srv/quartermaster/microsoft/mount',
    '/srv/quartermaster/microsoft/winpe',
    '/srv/quartermaster/microsoft/winpe/bin',
    '/srv/quartermaster/microsoft/winpe/system',
    '/srv/quartermaster/microsoft/winpe/system/menu',
  ]:
    ensure  => directory,
    mode    => '0777',
# nginx module  0.5.0
#    owner   => 'nginx',
#    group   => 'nginx',
    owner   => $::nginx::daemon_user,
    group   => $::nginx::daemon_user,
    recurse => true,
  } ->
  file{ '/srv/quartermaster/tftpboot':
    ensure  => directory,
    mode    => '0777',
    owner   => $::tftp::username,
    group   => $::tftp::username,
    recurse => true,
  } ->
  ## .README.html (FILE) /srv/quartermaster/distro/.README.html
  file{[
    '/srv/quartermaster/.README.html',
    '/srv/quartermaster/bin/.README.html',
    '/srv/quartermaster/iso/.README.html',
    '/srv/quartermaster/logs/.README.html',
    '/srv/quartermaster/usb/.README.html',
    '/srv/quartermaster/kickstart/.README.html',
    '/srv/quartermaster/preseed/.README.html',
    '/srv/quartermaster/tftpboot/.README.html',
    '/srv/quartermaster/unattend.xml/.README.html',
    '/srv/quartermaster/microsoft/.README.html',
    '/srv/quartermaster/microsoft/iso/.README.html',
    '/srv/quartermaster/microsoft/winpe/.README.html',
    '/srv/quartermaster/microsoft/winpe/bin/README.html',
    '/srv/quartermaster/microsoft/winpe/system/README.html',
    '/srv/quartermaster/microsoft/winpe/system/menu/.README.html',
  ]:
    ensure  => file,
    owner   => $::nginx::daemon_user,
    group   => $::nginx::daemon_user,
    mode    => '0644',
    content => '<html>
<head>
<title>Quartermaster</title></head>
<style>
div.container {
    width: 100%;
    border: 0px solid gray;
}

header, footer {
    padding: 1em;
    color: white;
    background-color: black;
    clear: left;
    text-align: center;
}

nav {
    float: left;
    max-width: 240px;
    margin: 0;
    padding: 1em;
}

nav ul {
    list-style-type: none;
    padding: 0;
}
   
nav ul a {
    text-decoration: none;
}
nav iframe {
    border-width: 0px;
}

article {
    margin-left: 170px;
<!--    border-left: 2px solid gray; -->
    padding: 1em;
    overflow: hidden;
}
</style>
</head>
<body>
<div class="container">
<header>
Supplies, Tools & Provisions
</header>
<nav>
<ul>
<li><img src="http://images.vector-images.com/217/quartermaster_corps_emb_n11082.gif" alt="Quartermaster Military Insignia" height="100"></li>
<li><h4><u>Nginx Status</u></h4>
<iframe src="http://quartermaster.openstack.tld/status" frameborder="0" width="240" height="80" >Nginx Status</iframe></li>
</ul>
</nav>
<article>
<dl>
<dt><h1>Quartermaster</h1><dt>
<dd> A military or naval term, the meaning of which depends on the country and service.</dd>
<dd>In land armies, a quartermaster is generally a relatively senior soldier who supervises stores and 
distributes supplies and provisions.</dd>
<dd>In many navies, quartermaster is a non-commissioned officer (petty officer) rank.</dd>
</dl>
<small>
<ul style="list-style-type:disc">
<li>Quartermaster - <a href="https://en.wikipedia.org/wiki/Quartermaster">Wikipedia</a> </li>
</ul>
</small>
</article>
<footer>
<small>
***
<a href="https://github.com/ppouliot/puppet-quartermaster.git">
Quartermaster on GitHub
</a>
***
</small>
</footer></div></body></html>
',
  }

  file { '/srv/quartermaster/bin/concatenate_files.sh':
    ensure  => present,
    owner   => 'nobody',
    group   => 'nogroup',
    mode    => '0777',
    content => '#!/bin/bash
# First argument ($1): directory containing the file fragments
# Second argument ($2): path to the resulting file
rm -rf $2
# Concatenate the fragments
for FRAGMENT in `ls $1`; do
     cat $1/$FRAGMENT >> $2
done
',
  } ->

  # Firstboot Script
  # This is script is added to the ubuntu/debian hosts via
  # the postinstall script. It will install configuration management
  # packages, the secondboot script, sets hostname and additional 
  # startup config then reboots.

  file {'/srv/quartermaster/bin/firstboot':
    ensure  => file,
    mode    => '0777',
    content => template('quartermaster/scripts/firstboot.erb'),
  } ->

  # Secondboot Script
  # Executes configuration managment ( Puppet Currently )
  file {'/srv/quartermaster/bin/secondboot':
    ensure  => file,
    mode    => '0777',
    content => template('quartermaster/scripts/secondboot.erb'),
  } ->

  # Postinstall Script
  # Installs the firstboot script and reboots the system
  file {'/srv/quartermaster/bin/postinstall':
    ensure  => file,
    mode    => '0777',
    content => template('quartermaster/scripts/postinstall.erb'),
  }
  file{'/srv/quartermaster/microsoft/winpe/system/init.cmd':
    ensure  => file,
    mode    => '0777',
    content => template('quartermaster/winpe/menu/init.erb'),
  } ->
  file {'/srv/quartermaster/microsoft/winpe/system/menucheck.ps1':
    ensure  => file,
    mode    => '0777',
    content => template('quartermaster/winpe/menu/menucheckps1.erb'),
  } ->
  file {'/srv/quartermaster/microsoft/winpe/system/puppet_log.ps1':
    ensure  => file,
    mode    => '0777',
    content => template('quartermaster/scripts/puppet_log.ps1.erb'),
  } ->
  file {'/srv/quartermaster/microsoft/winpe/system/firstboot.cmd':
    ensure  => file,
    mode    => '0777',
    content => template('quartermaster/scripts/firstbootcmd.erb'),
  } ->
  file {'/srv/quartermaster/microsoft/winpe/system/secondboot.cmd':
    ensure  => file,
    mode    => '0777',
    content => template('quartermaster/scripts/secondbootcmd.erb'),
  }->
  file {'/srv/quartermaster/microsoft/winpe/system/compute.cmd':
    ensure  => file,
    mode    => '0777',
    content => template('quartermaster/scripts/computecmd.erb'),
  }->
  file {'/srv/quartermaster/microsoft/winpe/system/puppetinit.cmd':
    ensure  => file,
    mode    => '0777',
    content => template('quartermaster/scripts/puppetinitcmd.erb'),
  } ->
  file {'/srv/quartermaster/microsoft/winpe/system/rename.ps1':
    ensure  => file,
    mode    => '0777',
    content => template('quartermaster/scripts/rename.ps1.erb'),
  }

  # Configured a resolv.conf for dnsmasq to use
  file {[
    '/srv/quartermaster/tftpboot',
    '/srv/quartermaster/tftpboot/menu',
    '/srv/quartermaster/tftpboot/network_devices',
    '/srv/quartermaster/tftpboot/pxelinux',
    '/srv/quartermaster/tftpboot/pxelinux/pxelinux.cfg',
    '/srv/quartermaster/tftpboot/winpe',
  ]:
    ensure => directory,
    mode   => '0777',
  }


  concat {'/srv/quartermaster/tftpboot/pxelinux/pxelinux.cfg/default':
    owner => $::tftp::username,
    group => $::tftp::username,
  }
  concat::fragment{'default_header':
    target  => '/srv/quartermaster/tftpboot/pxelinux/pxelinux.cfg/default',
    content => template('quartermaster/pxemenu/header.erb'),
    order   => 01,
  }

  concat::fragment{'default_localboot':
    target  => '/srv/quartermaster/tftpboot/pxelinux/pxelinux.cfg/default',
    content => template('quartermaster/pxemenu/localboot.erb'),
    order   => 01,
  }

file {'/srv/quartermaster/pxelinux/graphics.cfg':
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
  # Syslinux Staging and Extraction
  concat::fragment{'winpe_pxe_default_menu':
    target  => '/srv/quartermaster/tftpboot/pxelinux/pxelinux.cfg/default',
    content => template('quartermaster/pxemenu/winpe.erb'),
    require => Tftp::File['pxelinux/pxelinux.cfg']
  }

# Refactore Needed

  concat { '/srv/quartermaster/microsoft/winpe/system/setup.cmd': }
  concat::fragment{'winpe_system_cmd_a00_header':
    target  => '/srv/quartermaster/microsoft/winpe/system/setup.cmd',
    content => template('quartermaster/winpe/menu/A00_init.erb'),
    order   => 01,
  }
  concat::fragment{'winpe_system_cmd_b00_init':
    target  => '/srv/quartermaster/microsoft/winpe/system/setup.cmd',
    content => template('quartermaster/winpe/menu/B00_init.erb'),
    order   => 10,
  }
  concat::fragment{'winpe_system_cmd_c00_init':
    target  => '/srv/quartermaster/microsoft/winpe/system/setup.cmd',
    content => template('quartermaster/winpe/menu/C00_init.erb'),
    order   => 20,
  }
  concat::fragment{'winpe_menu_footer':
    target  => '/srv/quartermaster/microsoft/winpe/system/setup.cmd',
    content => template('quartermaster/winpe/menu/D00_init.erb'),
    order   => 99,
  }

}
