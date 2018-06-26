# A description of what this class does
#
# @summary A short summary of the purpose of this class
#
# @example
#   include pxe2_ipxe_menus
class pxe2_ipxe_menus (
  String $pxe2_path                                  = '/pxe2',
  String $pxe2_hostname                              = 'pxe.to',
  Optional[String] $preferred_nameserver             = undef,
  Optional[Boolean] $dban_enable                     = undef,
  Optional[String] $dban_version                     = '2.3.0',
  Optional[String] $go_version                       = '1.9.2',
  Optional[String] $terraform_version                = '0.11.0',
  Optional[String] $jenkins_swarm_version_to_use     = '3.3',
  String $default_pxeboot_option                     = 'menu.c32',
  String $pxe_menu_timeout                           = '10',
  String $pxe_menu_total_timeout                     = '120',
  String $pxe_menu_allow_user_arguments              = '0',
  Optional[String] $puppetmaster                     = undef,
  Optional[String] $use_local_proxy                  = undef,
  String $vnc_passwd                                 = 'letmein',
  Optional[String] $etcd_token                       = '42af8a395def005a2b952b429de3417f'

) inherits pxe2_ipxe_menus::params {

  class{'::pxe2_ipxe_menus::files': }
->class{'::pxe2_ipxe_menus::configure': }

  contain pxe2_ipxe_menus::files
  contain pxe2_ipxe_menus::configure

}
