# A description of what this defined type does
#
# @summary This Class defines the creation of the linux ipxe menu infrastructure
#
# @example
#   pxe2_ipxe_menus::linux_menu { 'namevar': }

define pxe2_ipxe_menus::linux_menu(
  # The following pxe menu variables are required for the templates used in this class
  String $pxe2_path                               = $pxe2_ipxe_menus::pxe2_path,
  String $pxe2_hostname                           = $pxe2_ipxe_menus::pxe2_hostname,
  String $default_pxeboot_option                  = $pxe2_ipxe_menus::default_pxeboot_option,
  String $pxe_menu_timeout                        = $pxe2_ipxe_menus::pxe_menu_timeout,
  String $pxe_menu_total_timeout                  = $pxe2_ipxe_menus::pxe_menu_total_timeout,
  String $pxe_menu_allow_user_arguments           = $pxe2_ipxe_menus::pxe_menu_allow_user_arguments,
  String $syslinux_version                        = $pxe2_ipxe_menus::syslinux_version,
  Optional[String] $puppetmaster                  = $pxe2_ipxe_menus::puppetmaster,
  Optional[String] $jenkins_swarm_version_to_use  = $pxe2_ipxe_menus::jenkins_swarm_version_to_use,
  Optional[String] $use_local_proxy               = $pxe2_ipxe_menus::use_local_proxy,
  String $vnc_passwd                              = $pxe2_ipxe_menus::vnc_passwd,
){

# this regex works w/ no .
#if $name =~ /([a-zA-Z0-9_]+)-([a-zA-Z0-9_]+)-([a-zA-Z0-9_]+)/ {

  # Define proper name formatting matching distro-release-p_arch
  if $name =~ /([a-zA-Z0-9_\.]+)-([a-zA-Z0-9_\.]+)-([a-zA-Z0-9_\.]+)/ {
    $distro  = $1
    $release = $2
    $p_arch  = $3
    notice($distro)
    notice($release)
    notice($p_arch)
    validate_string($distro, '^(debian|devuan|centos|fedora|kali|scientificlinux|opensuse|oraclelinux|ubuntu)$', 'The currently supported values for distro are debian, devuan, centos, fedora, kali, oraclelinux, scientificlinux, opensuse',)
    validate_string($p_arch, '^(i386|i586|i686|x86_65|amd64)$', 'The currently supported values for pocessor architecture  are i386,i586,i686,x86_64,amd64',)
  } else {
    fail('You must put your entry in format "<Distro>-<Release>-<Processor Arch>" like "centos-7-x86_64" or "ubuntu-14.04-amd64"')
  }
  # convert release into rel_number to check to major and minor releases
  $rel_number = regsubst($release, '(\.)','','G')
  notice($rel_number)

  if $release =~/([0-9]+).([0-9])/{
    $rel_major = $1
    $rel_minor = $2
    notice($rel_major)
    notice($rel_minor)
  } else {
    warning("${distro} ${release} does not have major and minor point releases for ${name}.")
  }

  if ( $distro == 'centos') {
    case $release {
      '2.1','3.1','3.3','3.4','3.5','3.6','3.7','3.8','3.9',
      '4.0','4.1','4.2','4.3','4.4','4.5','4.6','4.7','4.8','4.9',
      '5.0','5.1','5.2','5.3','5.4','5.5','5.6','5.7','5.8','5.9','5.10','5.11':{
        $centos_url = "http://vault.centos.org/${release}"
        $_dot_bootsplash = '.lss'
        $vnc_option        = 'vnc'
        $vnc_option_passwd = 'vncpasswd'
        $ks_option         = 'ks'
        $url_option        = 'url'

      }
      '6.0','6.1','6.2','6.3','6.4','6.5','6.6','6.7':{
        $centos_url = "http://vault.centos.org/${release}"
        $_dot_bootsplash = '.jpg'
        $vnc_option        = 'vnc'
        $vnc_option_passwd = 'vncpasswd'
        $ks_option         = 'ks'
        $url_option        = 'url'
      }
      '6.8':{
        $centos_url = "http://vault.centos.org/centos/${release}"
        $_dot_bootsplash = '.png'
        $vnc_option        = 'inst.vnc'
        $vnc_option_passwd = 'inst.vncpasswd'
        $ks_option         = 'ks'
        $url_option        = 'url'
      }
      '6.9':{
        $centos_url = "http://mirror.centos.org/centos/${release}"
        $_dot_bootsplash = '.png'
        $vnc_option        = 'inst.vnc'
        $vnc_option_passwd = 'inst.vncpasswd'
        $ks_option         = 'ks'
        $url_option        = 'url'
      }
      '7.0.1406','7.1.1503','7.2.1511','7.3.1611':{
        $centos_url = "http://vault.centos.org/centos/${release}"
        $_dot_bootsplash = '.png'
        $vnc_option        = 'inst.vnc'
        $vnc_option_passwd = 'inst.vncpasswd'
        $ks_option         = 'ks'
        $url_option        = 'inst.repo'
      }
      '7.4.1708':{
        $centos_url = "http://mirror.centos.org/centos/${release}"
        $_dot_bootsplash = '.png'
        $vnc_option        = 'inst.vnc'
        $vnc_option_passwd = 'inst.vncpasswd'
        $ks_option         = 'ks'
        $url_option        = 'inst.repo'
      }
      default:{
        warning("${name} is not a centos release")
      }
    }
    notice($centos_url)
    $autofile        = 'kickstart'
    $linux_installer = 'anaconda'
    $pxekernel       = 'vmlinuz'
    $initrd          = '.img'
    $src_initrd      = "initrd${initrd}"
    $target_kernel   = $rel_number
    $target_initrd   = "${rel_number}${initrd}"
    $url             = "${centos_url}/os/${p_arch}/images/pxeboot"
    $inst_repo       = "${centos_url}/os/${p_arch}/"
    $update_repo     = "${centos_url}/updates/${p_arch}/"
    $splashurl       = "${centos_url}/isolinux/splash${_dot_bootsplash}"
    $boot_iso_url    = "${centos_url}/os/${p_arch}/images/${boot_iso_name}"
    $boot_iso_name   = 'boot.iso'
    $mini_iso_name   = 'boot.iso'
  }

  if ( $distro == 'fedora') {
    case $release {
      '2','3','4','5','6':{
        $fedora_url        = 'http://archives.fedoraproject.org/pub/archive/fedora/linux/core'
        $fedora_flavor     = ''
        $_dot_bootsplash   = '.lss'
        $vnc_option        = 'vnc'
        $vnc_option_passwd = 'vncpasswd'
        $ks_option         = 'ks'
        $url_option        = 'url'
      }
      '7','8','9','10','11','12','13','14','15','16','17','18','19','20':{
        $fedora_url        = 'http://archives.fedoraproject.org/pub/archive/fedora/linux/releases'
        $fedora_flavor     = 'Fedora/'
        $_dot_bootsplash   = '.jpg'
        $vnc_option        = 'vnc'
        $vnc_option_passwd = 'vncpasswd'
        $ks_option         = 'ks'
        $url_option        = 'url'
      }
      '21':{
        $fedora_url        = 'http://archives.fedoraproject.org/pub/archive/fedora/linux/releases'
        $fedora_flavor     = 'Server/'
        $_dot_bootsplash   = '.png'
        $vnc_option        = 'vnc'
        $vnc_option_passwd = 'vncpasswd'
        $ks_option         = 'ks'
        $url_option        = 'url'
      }
      '22','23','24':{
        # Currently http://download.fedoraproject.org redirects to a mirror using a mirror to satisify installations.
        $fedora_url        = 'http://archives.fedoraproject.org/pub/archive/fedora/linux/releases'
        $fedora_flavor     = 'Server/'
        $_dot_bootsplash   = '.png'
        $vnc_option        = 'inst.vnc'
        $vnc_option_passwd = 'inst.vncpasswd'
        $ks_option         = 'inst.ks'
        $url_option        = 'url'
      }
      '25','26','27':{
        # Currently http://download.fedoraproject.org redirects to a mirror using a mirror to satisify installations.
        #$fedora_url = 'http://download.fedoraproject.org/fedora/linux/releases'
        $fedora_url = 'http://mirrors.mit.edu/fedora/linux/releases'
        $fedora_flavor  = 'Server/'
        $_dot_bootsplash = '.png'
        $vnc_option        = 'inst.vnc'
        $vnc_option_passwd = 'inst.vncpasswd'
        $ks_option         = 'inst.ks'
        $url_option        = 'inst.repo'
      }
      default:{
        warning("${name} isn't a fedora release!")
      }
    }
    notice($fedora_url)
    notice($fedora_flavor)
    $autofile        = 'kickstart'
    $linux_installer = 'anaconda'
    $pxekernel       = 'vmlinuz'
    $initrd          = '.img'
    $src_initrd      = "initrd${initrd}"
    $target_kernel   = $rel_number
    $target_initrd   = "${rel_number}${initrd}"
    $url             = "${fedora_url}/${release}/${fedora_flavor}${p_arch}/os/images/pxeboot"
    $inst_repo       = "${fedora_url}/${release}/${fedora_flavor}${p_arch}/os"
    $update_repo     = "${fedora_url}/${release}/${fedora_flavor}${p_arch}/os"
    $boot_iso_url    = "${fedora_url}/${release}/${fedora_flavor}${p_arch}/os/images/boot.iso"
    $boot_iso_name   = 'boot.iso'
    $mini_iso_name   = 'boot.iso'
    $splashurl       = "${fedora_url}/isolinux/splash${_dot_bootsplash}"
  }
  if ( $distro == 'scientificlinux'){
    case $release {
      '50','51','52','53','54','55','56','57','58','59','510','511':{
        $scientificlinux_url = "http://ftp.scientificlinux.org/linux/scientific/obsolete/${release}/${p_arch}"
        $_dot_bootsplash     = '.lss'
        $vnc_option          = 'vnc'
        $vnc_option_passwd   = 'vncpasswd'
        $ks_option           = 'ks'
        $url_option          = 'url'
      }
      '6.0','6.1','6.2','6.3','6.4','6.5','6.6','6.7','6.8','6.9':{
        $scientificlinux_url = "http://ftp.scientificlinux.org/linux/scientific/${release}/${p_arch}/os"
        $_dot_bootsplash     = '.jpg'
        $vnc_option          = 'vnc'
        $vnc_option_passwd   = 'vncpasswd'
        $ks_option           = 'ks'
        $url_option          = 'url'
      }
      '7.0','7.1','7.2','7.3','7.4':{
        $scientificlinux_url = "http://ftp.scientificlinux.org/linux/scientific/${release}/${p_arch}/os"
        $_dot_bootsplash     = '.png'
        $vnc_option          = 'inst.vnc'
        $vnc_option_passwd   = 'inst.vncpasswd'
        $ks_option           = 'inst.ks'
        $url_option          = 'url'
      }
      default:{
        warning("${name} isn't a scientificlinux release!")
      }
    }
    notice($scientificlinux_url)
    $autofile        = 'kickstart'
    $linux_installer = 'anaconda'
    $pxekernel       = 'vmlinuz'
    $initrd          = '.img'
    $src_initrd      = "initrd${initrd}"
    $target_kernel   = $rel_number
    $target_initrd   = "${rel_number}${initrd}"
    $url             = "${scientificlinux_url}/images/pxeboot"
    $inst_repo       = "http://ftp.scientificlinux.org/linux/scientific/${release}/${p_arch}/os"
    $update_repo     = "http://ftp.scientificlinux.org/linux/scientific/${release}/${p_arch}/updates/security"
    $splashurl       = "${scientificlinux_url}/isolinux/splash${_dot_bootsplash}"
    $boot_iso_url    = "${scientificlinux_url}/images/${boot_iso_name}"
    $boot_iso_name   = 'boot.iso'
    $mini_iso_name   = 'boot.iso'
  }

  if ( $distro == 'opensuse') {
    case $release {
      '10.2','10.3','11.0','11.1','11.2','11.3','11.4','12.1','12.2','12.3','13.1','13.2','13.3':{
        warning("OpenSUSE ${release} for ${p_arch} a discontinued distribution downloaded from ${url}")
        $opensuse_url = 'http://ftp5.gwdg.de/pub/opensuse/discontinued/distribution'
      }
      'tumbleweed':{
        warning("OpenSUSE ${release} rolling upgrades")
        $opensuse_url = 'http://download.opensuse.org'
      }
      '42.2','42.3':{
        warning("OpenSUSE ${release} LEAP")
        $opensuse_url = 'http://download.opensuse.org/distribution/leap'
      }
      default:{
        warning("${name} isn't a openSuSE release!")
      }
    }
      notice($opensuse_url)
    $autofile        = 'autoyast'
    $linux_installer = 'yast'
    $pxekernel       = 'linux'
    $initrd          = undef
    $src_initrd      = "initrd${initrd}"
    $target_kernel   = $rel_number
    $target_initrd   = "${rel_number}.gz"
    $_dot_bootsplash = '.jpg'
    $url             = "${opensuse_url}/${release}/repo/oss/boot/${p_arch}/loader"
    $inst_repo       = "${opensuse_url}/${release}/repo/oss"
    $update_repo     = "${opensuse_url}/${release}/repo/non-oss/suse"
    $splash_url      = "${opensuse_url}/${release}/repo/oss/boot/${p_arch}/loader/back.jpg"
    $boot_iso_url    = "${opensuse_url}/${release}/iso"
    $boot_iso_name   = "openSUSE-${release}-net-${p_arch}.iso"
    $mini_iso_name   = undef

    # This adds scripts to deploy to the system after booting into OpenSuse
    # when finished it should reboot.
    file {"/${pxe2_path}/src/${autofile}/kernelbuilder.${name}.${autofile}":
      ensure  => file,
      mode    => '0777',
      content => template('pxe2_ipxe_menus/kernelbuilder/autoyast.erb'),
    }
  }
  if ($distro == /(centos|fedora|oraclelinux)/) and ( $release >= '7.0' ) and ( $p_arch == 'i386'){
    fail("${distro} ${release} does not provide support for processor architecture i386")
  }

  # Begin tests for dealing with OracleLinux Repos
  if ( $distro == 'oraclelinux' ) {
    case $release {
      '4.4','4.5','4.6','4.7','4.8':{
        warning("There are currently no ${p_arch}-boot.iso on mirror so switching to Server ISO for ${name}")
        $boot_iso_name = "Enterprise-R${rel_major}-U${rel_minor}-${p_arch}-dvd.iso"
        $boot_iso_url    = "http://mirrors.kernel.org/oracle/EL${rel_major}/U${rel_minor}/${p_arch}/${boot_iso_name}"
        $mini_iso_name     = undef
        $_u                = 'U'
        $vnc_option        = 'vnc'
        $vnc_option_passwd = 'vncpasswd'
        $ks_option         = 'ks'
        $url_option        = 'url'

      }
      '5.0':{
        warning("There are currently no ${p_arch}-boot.iso on mirror so switching to Server ISO for ${name}")
        $boot_iso_name = "Enterprise-R${rel_major}-U${rel_minor}-Server-${p_arch}-dvd.iso"
        $boot_iso_url    = "http://mirrors.kernel.org/oracle/EL${rel_major}/GA/${p_arch}/${boot_iso_name}"
        $mini_iso_name     = undef
        $_u                = 'U'
        $vnc_option        = 'vnc'
        $vnc_option_passwd = 'vncpasswd'
        $ks_option         = 'ks'
        $url_option        = 'url'
      }

      '5.1','5.2','5.3','5.4','5.5','5.6','5.7','5.8','5.9','5.10','5.11':{
        warning("There are currently no ${p_arch}-boot.iso on mirror so switching to Server ISO for ${name}")
        $boot_iso_name = "Enterprise-R${rel_major}-U${rel_minor}-Server-${p_arch}-dvd.iso"
        $boot_iso_url    = "http://mirrors.kernel.org/oracle/EL${rel_major}/U${rel_minor}/${p_arch}/${boot_iso_name}"
        $mini_iso_name     = undef
        $_u                = 'U'
        $vnc_option        = 'vnc'
        $vnc_option_passwd = 'vncpasswd'
        $ks_option         = 'ks'
        $url_option        = 'url'
      }

      '6.0':{
        warning("There are currently no ${p_arch}-boot.iso on mirror so switching to Server ISO for ${name}")
        $boot_iso_name = "OracleLinux-R${rel_major}-U${rel_minor}-Server-${p_arch}-dvd.iso"
        $boot_iso_url    = "http://mirrors.kernel.org/oracle/OL${rel_major}/GA/${p_arch}/${boot_iso_name}"
        $mini_iso_name     = undef
        $_u                = 'U'
        $vnc_option        = 'vnc'
        $vnc_option_passwd = 'vncpasswd'
        $ks_option         = 'ks'
        $url_option        = 'url'
      }

      '6.1','6.2','6.3','6.4','6.5','6.6','6.7','6.8','6.9':{
        warning("There are currently no ${p_arch}-boot.iso on mirror so switching to Server ISO for ${name}")
        $boot_iso_name     = "OracleLinux-R${rel_major}-U${rel_minor}-Server-${p_arch}-dvd.iso"
        $boot_iso_url      = "http://mirrors.kernel.org/oracle/OL${rel_major}/U${rel_minor}/${p_arch}/${boot_iso_name}"
        $mini_iso_name     = "${p_arch}-boot.iso"
        $_u                = 'U'
        $vnc_option        = 'vnc'
        $vnc_option_passwd = 'vncpasswd'
        $ks_option         = 'ks'
        $url_option        = 'url'
      }

      '7.0':{
        warning("There are currently no ${p_arch}-boot.iso on mirror so switching to Server ISO for ${name}")
        $boot_iso_name = "OracleLinux-R${rel_major}-U${rel_minor}-Server-${p_arch}-dvd.iso"
        $boot_iso_url    = "http://mirrors.kernel.org/oracle/OL${rel_major}/GA/${p_arch}/${boot_iso_name}"
        $mini_iso_name     = "${p_arch}-boot.iso"
        $_u                = 'u'
        $vnc_option        = 'inst.vnc'
        $vnc_option_passwd = 'inst.vncpasswd'
        $ks_option         = 'inst.ks'
        $url_option        = 'inst.repo'
      }

      '7.1','7.2','7.3','7.4':{
        warning("There are currently no ${p_arch}-boot.iso on mirror so switching to Server ISO for ${name}")
        $boot_iso_name     = "OracleLinux-R${rel_major}-U${rel_minor}-Server-${p_arch}-dvd.iso"
        $boot_iso_url      = "http://mirrors.kernel.org/oracle/OL${rel_major}/u${rel_minor}/${p_arch}/${boot_iso_name}"
        $mini_iso_name     = undef
        $_u                = 'u'
        $vnc_option        = 'inst.vnc'
        $vnc_option_passwd = 'inst.vncpasswd'
        $ks_option         = 'inst.ks'
        $url_option        = 'inst.repo'
      }

      '7.5':{
        warning("There are currently no ${p_arch}-boot.iso on mirror so switching to Server ISO for ${name}")
        $boot_iso_name     = "OracleLinux-R${rel_major}-U${rel_minor}-Server-${p_arch}-dvd.iso"
        $boot_iso_url      = "http://mirrors.kernel.org/oracle/OL${rel_major}/u${rel_minor}/${p_arch}/${boot_iso_name}"
        $mini_iso_name     = "${p_arch}-boot.iso"
        $_u                = 'u'
        $vnc_option        = 'inst.vnc'
        $vnc_option_passwd = 'inst.vncpasswd'
        $ks_option         = 'inst.ks'
        $url_option        = 'inst.repo'
      }
      default:{
        warning("${name} isn't a oraclelinux release!")
      }
    }
    notice($_u)
    $autofile        = 'kickstart'
    $linux_installer = 'anaconda'
    $pxekernel       = 'vmlinuz'
    $initrd          = '.img'
    $src_initrd      = "initrd${initrd}"
    $target_kernel   = $rel_number
    $target_initrd   = "${rel_number}${initrd}"
    $_dot_bootsplash = '.png'
    $url             = 'ISO Required instead of URL'
#    $inst_repo      = "http://public-yum.oracle.com/repo/oracle/OracleLinux/OL${rel_major}/${rel_minor}/base/${p_arch}"
#    $inst_repo      = "http://${::fqdn}/${distro}/mnt/OracleLinux-R${rel_major}-U${rel_minor}-Server-${p_arch}-dvd.iso"
    $inst_repo       = "http://${::fqdn}/${distro}/mnt/${boot_iso_name}"
#    $update_repo    = "http://yum.oracle.com/repo/OracleLinux/oracle/OL${rel_major}/latest/${p_arch}"
    $update_repo     = "http://public-yum.oracle.com/repo/oracle/OracleLinux/OL${rel_major}/${rel_minor}/base/${p_arch}"
    $splashurl       = "http://mirrors.kernel.org/oracle/OL${rel_major}/${rel_minor}/base/${p_arch}"
  }
  if ( $distro == 'redhat' ) {
    $autofile        = 'kickstart'
    $linux_installer = 'anaconda'
    $pxekernel       = 'vmlinuz'
    $initrd          = '.img'
    $src_initrd      = "initrd${initrd}"
    $target_kernel   = $rel_number
    $target_initrd   = "${rel_number}${initrd}"
    $_dot_bootsplash = '.jpg'
    $url             = 'ISO Required instead of URL'
    $inst_repo       = 'Install ISO Required'
    $update_repo     = 'Update ISO or Mirror Required'
    $splashurl       = 'ISO Required for Splash'
    $boot_iso_url    = 'No mini.iso or boot.iso to download'
    $boot_iso_name   = 'Not Required'
    $ks_option       = 'ks'
    $url_option      = 'url'
  }
  if ( $distro == 'sles' ) {
    $autofile        = 'autoyast'
    $linux_installer = 'yast'
    $pxekernel       = 'linux'
    $initrd          = undef
    $src_initrd      = "initrd${initrd}"
    $target_kernel   = $rel_number
    $target_initrd   = "${rel_number}.gz"
    $_dot_bootsplash = '.jpg'
    $url             = 'ISO Required instead of URL'
    $inst_repo       = 'Install ISO Required'
    $update_repo     = 'Update ISO or Mirror Required'
    $splashurl       = 'ISO Required for Splash'
    $boot_iso_url    = 'No mini.iso or boot.iso to download'
    $boot_iso_name   = 'Not Required'
  }
  if ( $distro == 'sled' ) {
    $autofile        = 'autoyast'
    $linux_installer = 'yast'
    $pxekernel       = 'linux'
    $initrd          = undef
    $src_initrd      = "initrd${initrd}"
    $target_kernel   = $rel_number
    $target_initrd   = "${rel_number}.gz"
    $_dot_bootsplash = '.jpg'
    $url             = 'ISO Required instead of URL'
    $inst_repo       = 'Install ISO Required'
    $update_repo     = 'Update ISO or Mirror Required'
    $splashurl       = 'ISO Required for Splash'
    $boot_iso_url    = 'No mini.iso or boot.iso to download'
    $boot_iso_name   = 'Not Required'
    $mini_iso_name   = 'Not Required'
  }
  if ( $distro == 'windows' ) {
    $autofile = 'unattend.xml'
  }


  if ( $distro == 'ubuntu' ) {
    $rel_name = $release ? {
      /(11.04)/     => 'natty',
      /(11.10)/     => 'oneric',
      /(12.04)/     => 'precise',
      /(12.10)/     => 'quantal',
      /(13.04)/     => 'raring',
      /(13.10)/     => 'saucy',
      /(14.04)/     => 'trusty',
      /(14.10)/     => 'utopic',
      /(15.04)/     => 'vivid',
      /(15.10)/     => 'wily',
      /(16.04)/     => 'xenial',
      /(16.10)/     => 'yakkety',
      /(17.04)/     => 'zesty',
      /(17.10)/     => 'artful',
      /(18.04)/     => 'bionic',
      default       => "${name} is not an Ubuntu release",
    }
    case $release {
      '12.04','14,04','15.04','16.04','17.10','18.04':{
        warning("Ubuntu ${release} is an active release")
      }
      default:{
        warning("${name} isn't an active ubuntu release!")
      }
    }
    $autofile        = 'preseed'
    $linux_installer = 'd-i'
    $pxekernel       = 'linux'
    $initrd          = '.gz'
    $src_initrd      = "initrd${initrd}"
    $target_kernel   = $rel_number
    $target_initrd   = "${rel_number}${initrd}"
    $_dot_bootsplash      = '.png'
    $mirror_host     = 'mirrors.kernel.org'
    $mirror_path     = $distro
    $url             = "http://archive.ubuntu.com/${distro}/dists/${rel_name}/main/installer-${p_arch}/current/images/netboot/debian-installer/${p_arch}"
    $inst_repo       = "http://archive.ubuntu.com/${distro}/dists/${rel_name}"
    $update_repo     = "http://archive.ubuntu.com/${distro}/dists/${rel_name}"
    $splashurl       = "http://archive.ubuntu.com/${distro}/dists/${rel_name}/main/installer-${p_arch}/current/images/netboot/debian-installer/${p_arch}/boot-screens/splash${_dot_bootsplash}"
    $boot_iso_url    = 'No mini.iso or boot.iso to download'
    $boot_iso_name   = 'Not Required'
    $mini_iso_name   = 'mini.iso'
  }

  if ( $distro == 'devuan' ) {
    $rel_name = $release ? {
      /(1.0)/   => 'jessie',
      /(2.0)/   => 'ascii',
      /(3.0)/   => 'beowulf',
      default   => "${name} is not an Devuan release",
    }
    case $release {
      '1.0','2.0':{
        $devuan_url  = 'http://pkgmaster.devuan.org'
        $mirror_host = 'pkgmaster.devuan.org'
        $mirror_path = $distro
      }
      default:{
        warning("${name} isn't a devuan release!")
      }
    }
    $autofile        = 'preseed'
    $linux_installer = 'd-i'
    $pxekernel       = 'linux'
    $initrd          = '.gz'
    $src_initrd      = "initrd${initrd}"
    $target_kernel   = $rel_number
    $target_initrd   = "${rel_number}${initrd}"
    $_dot_bootsplash = '.png'
    $url             = "${devuan_url}/${distro}/dists/${rel_name}/main/installer-${p_arch}/current/images/netboot/${distro}-installer/${p_arch}"
    $inst_repo       = "${devuan_url}/${distro}/dists/${rel_name}"
    $update_repo     = "${devuan_url}/${distro}/dists/${rel_name}"
    $splashurl       = "${devuan_url}/${distro}/dists/${rel_name}/main/installer-${p_arch}/current/images/netboot/${distro}-installer/${p_arch}/boot-screens/splash${_dot_bootsplash}"
    $boot_iso_url    = 'No mini.iso or boot.iso to download'
    $boot_iso_name   = 'Not Required'
    $mini_iso_name   = 'Not Required'
  }

  if ( $distro == 'debian' ) {
    $rel_name = $release ? {
      /(2.0)/ => 'hamm',
      /(2.1)/ => 'slink',
      /(2.2)/ => 'potato',
      /(3)/   => 'woody',
      /(3.1)/ => 'sarge',
      /(4)/   => 'etch',
      /(5)/   => 'lenny',
      /(6)/   => 'squeeze',
      /(7)/   => 'wheezy',
      /(8)/   => 'jessie',
      /(9)/   => 'stretch',
      /(10)/  => 'buster',
      /(11)/  => 'bullseye',
      default => "${name} is not an Debian release",
    }
    case $release {
      '2.0','2.1','2.2','3','3.1','4':{
        warning("${name} is not currently a pxeable debian release!")
      }
      '5','6':{
        $debian_url = 'http://archive.debian.org'
        $mirror_host = 'archive.debian.org'
        $mirror_path = $distro

      }
      '7','8','9','10':{
        $debian_url = 'http://http.us.debian.org'
        $mirror_host = 'http.us.debian.org'
        $mirror_path = $distro
      }
      default:{
        warning("${name} isn't a debian release!")
      }
    }
    $autofile        = 'preseed'
    $linux_installer = 'd-i'
    $pxekernel       = 'linux'
    $initrd          = '.gz'
    $src_initrd      = "initrd${initrd}"
    $target_kernel   = $rel_number
    $target_initrd   = "${rel_number}${initrd}"
    $_dot_bootsplash = '.png'
    $url             = "${debian_url}/${distro}/dists/${rel_name}/main/installer-${p_arch}/current/images/netboot/${distro}-installer/${p_arch}"
    $inst_repo       = "${debian_url}/${distro}/dists/${rel_name}"
    $update_repo     = "${debian_url}/${distro}/dists/${rel_name}"
    $splashurl       = "${debian_url}/${distro}/dists/${rel_name}/main/installer-${p_arch}/current/images/netboot/${distro}-installer/${p_arch}/boot-screens/splash${_dot_bootsplash}"
    $boot_iso_url    = 'No mini.iso or boot.iso to download'
    $boot_iso_name   = 'Not Required'
    $mini_iso_name   = 'Not Required'
  }
  if ( $distro == 'kali' ) {
    $autofile        = 'preseed'
    $linux_installer = 'd-i'
    $pxekernel       = 'linux'
    $initrd          = '.gz'
    $src_initrd      = "initrd${initrd}"
    $target_kernel   = $rel_number
    $target_initrd   = "${rel_number}${initrd}"
    $_dot_bootsplash = '.png'
    $mirror_host      = 'http.kali.org'
    $mirror_path     = $distro
    $url             = "http://http.kali.org/kali/dists/kali-rolling/main/installer-${p_arch}/current/images/netboot/debian-installer/${p_arch}"
    $inst_repo       = 'http://http.kali.org/kali/dists/kali-rolling'
    $update_repo     = 'http://http.kali.org/kali/dists/kali-rolling'
    $splashurl       = "http://http.kali.org/kali/dists/kali-rolling/main/installer-${p_arch}/current/images/netboot/debian-installer/${p_arch}/boot-screens/splash${_dot_bootsplash}"
    $boot_iso_url    = 'No mini.iso or boot.iso to download'
    $boot_iso_name   = 'Not Required'
    $mini_iso_name   = 'Not Required'
  }
  if ( $distro == 'archlinux' ){
    case $release {
      '2016.12.01','2017.01.01','2017.02.01','latest':{
        warning("Archlinux ${release} for ${p_arch} will be activated")
      }
      default:{
        fail(" \
${name} is not a valid Archlinux release! \
Try using 2016.12.01,2017.01.01,2017.02.01, \
or latest for your release vs. ${release} \
which you are curenntly using.")
      }
    }
    $autofile        = 'archiso'
    $linux_installer = 'archiso'
    $pxekernel       = 'vmlinuz'
    $initrd          = '.img'
    $src_initrd      = "initrd${initrd}"
    $target_kernel   = $rel_number
    $target_initrd   = "${rel_number}${initrd}"
    $_dot_bootsplash = '.png'
    $url             = "http://mirrors.kernel.org/archlinux/iso/${release}/arch/boot/${p_arch}"
    $inst_repo       = "http://mirrors.kernel.org/archlinux/iso/${release}/arch/boot/initramfs_${p_arch}.${initrd}"
    $update_repo     = "http://mirrors.kernel.org/archlinux/core/os/${p_arch}/${rel_name}/arch/${p_arch}/airootfs.sfs"
    $splashurl       = "http://mirrors.kernel.org/archlinux/iso/${rel_name}/arch/${p_arch}/airootfs.sfs"
    $boot_iso_url    = "http://mirrors.kernel.org/archlinux/iso/${rel_name}/archlinux-${rel_name}-dual.iso"
    $boot_iso_name   = 'Not Required'
    $mini_iso_name   = 'Not Required'
  }
  if ( $distro == 'coreos' ) {
    case $release {
      'stable': {
        warning("coreos ${release} for ${p_arch} will be activated")
        $coreos_version = '1520.8.0'
      }
      'beta': {
        warning("coreos ${release} for ${p_arch} will be activated")
        $coreos_version = '1576.2.0'
      }
      'alpha': {
        warning("coreos ${release} for ${p_arch} will be activated")
        $coreos_version = '1590.0.0'
      }
      default: {
        fail("${name} is not a valid coreos release! Valid release are stable, beta  or alpha.")
      }
    }
    case $p_arch {
      'amd64', 'arm64': {
        warning("coreos ${release} for ${p_arch} will be activated")
      }
      default: {
        fail("${p_arch} is not a valid processor architecture for coreos, valid processor arch are amd64 and arm64.")
      }
    }
    $coreos_channel = $release
    $autofile = 'cloud-config.yml'
    $linux_installer = 'coreos-install'
    $pxekernel = 'coreos_production_pxe.vmlinuz'
    $initrd = 'cpio.gz'
    $src_initrd = "coreos_production_pxe_image.${initrd}"
    $target_kernel = "${release}_production.vmlinuz"
    $target_initrd = "${release}_production.${initrd}"
    $url = "https://${release}.release.core-os.net/${p_arch}-usr/current"
    $inst_repo = "https://${release}.release.core-os.net/${p_arch}-usr/current"
    $boot_iso_url = "https://${release}.release.core-os.net/${p_arch}-usr/current/coreos_production_iso_image.iso"
    $boot_iso_name = 'Not Required'
    $mini_iso_name = 'Not Required'

    # This adds scripts to deploy to the system after booting into coreos 
    # when finished it should reboot.
    file { "/${pxe2_path}/src/${autofile}/${name}.pxe_installer.sh":
      ensure  => file,
      mode    => '0777',
      content => template('pxe2_ipxe_menus/scripts/pxe_installer.sh.erb'),
    }
    file { "/${pxe2_path}/src/${autofile}/${name}.running_instance.sh":
      ensure  => file,
      mode    => '0777',
      content => template('pxe2_ipxe_menus/scripts/running_instance.sh.erb'),
    }
    file { "/${pxe2_path}/src/${autofile}/${name}.custom_ip_resolution.sh":
      ensure  => file,
      mode    => '0777',
      content => template('pxe2_ipxe_menus/scripts/coreos.custom_ip_resolution.sh.erb'),
    }
  }
  if ( $distro == 'rancheros' ) {
    case $release {
      /([0-9]).([0-9]).([0-9])/:{
        warning("rancheros ${release} for ${p_arch} will be activated")
        $rancheros_release = "v${release}"
#        $src_initrd      = "initrd-${rancheros_release}"
        $src_initrd      = 'initrd'
      }
      'latest':{
        warning("rancheros ${release} for ${p_arch} will be activated")
        $rancheros_release = 'latest'
        $src_initrd      = 'initrd'
      }
      default:{
        fail("${name} is not a valid rancheros release! Valid release are stable, beta  or alpha.")
      }
    }
    case $p_arch {
      'amd64','arm64':{
        warning("rancher ${release} for ${p_arch} will be activated")
      }
      default:{
        fail("${p_arch} is not a valid processor architecture for coreos, valid processor arch are amd64 and arm64.")
      }
    }
    $autofile        = 'cloud-config.yml'
    $linux_installer = 'ros'
    $pxekernel       = 'vmlinuz'
    $initrd          = 'initrd'
    $target_kernel   = $rel_number
    $target_initrd   = "${rel_number}.img"
#   $url             = "https://releases.rancher.com/os/${rancheros_release}"
    $url             = "https://github.com/rancher/os/releases/download/${rancheros_release}"
    $inst_repo       = "https://github.com/rancher/os/releases/download/${rancheros_release}"
#   $inst_repo       = "https://releases.rancher.com/os/${rancheros_release}"
    $boot_iso_url    = "https://releases.rancher.com/os/${rancheros_release}/${boot_iso_name}"
    $boot_iso_name   = 'rancheros.iso'
    $mini_iso_name   = 'Not Required'

    file {"/${pxe2_path}/src/${autofile}/${name}.pxe_installer.sh":
      ensure  => file,
      mode    => '0777',
      content => template('pxe2_ipxe_menus/scripts/pxe_installer.sh.erb'),
    }
    file {"/${pxe2_path}/src/${autofile}/${name}.running_instance.sh":
      ensure  => file,
      mode    => '0777',
      content => template('pxe2_ipxe_menus/scripts/running_instance.sh.erb'),
    }
    file {"/${pxe2_path}/src/${autofile}/${name}.custom_ip_resolution.sh":
      ensure  => file,
      mode    => '0777',
      content => template('pxe2_ipxe_menus/scripts/coreos.custom_ip_resolution.sh.erb'),
    }
  }

  $puppetlabs_repo = $distro ? {
    /(ubuntu|debian)/                                    => "http://apt.puppet.com/dists/${rel_name}",
# These are for puppet 3.x packages
#    /(redhat|centos|scientificlinux|oraclelinux)/        => "http://yum.puppet.com/el/${rel_major}/products/${p_arch}",
#    /(fedora)/                                           => "http://yum.puppet.com/fedora/f${rel_number}/products/${p_arch}",
    /(fedora)/                                           => "http://yum.puppet.com/fedora/f${rel_number}/PC1/${p_arch}",
    /(redhat|centos|scientificlinux|oraclelinux)/        => "http://yum.puppet.com/el/${rel_major}/PC1/${p_arch}",
    default                                              => 'No PuppetLabs Repo',
  }
  notice(puppetlabs_repo)
  notice($_dot_bootsplash)
  notice($autofile)
  notice($linux_installer)
  notice($pxekernel)
  notice($initrd)
  notice($target_initrd)
  notice($url)
  notice($inst_repo)
  notice($update_repo)
  notice($splashurl)
  notice($boot_iso_url)
  notice($boot_iso_name)
  notice($rel_name)

#################################################
# Create Autofile Folders and Files
#################################################

  if ! defined (File["${pxe2_path}/src/${autofile}"]) {
    file { "${pxe2_path}/src/${autofile}":
      ensure  => directory,
      require => File[ "${pxe2_path}/src" ],
    }
    notice(File["${pxe2_path}/src/${autofile}"])
  }

  #  Distro Kickstart/Preseed File
  file { "${name}.${autofile}":
    ensure  => file,
    path    => "${pxe2_path}/src/${autofile}/${name}.${autofile}",
    content => template("pxe2_ipxe_menus/unattended_installation/${autofile}.erb"),
    require => File[ "${pxe2_path}/src/${autofile}" ],
  } notice(File["${pxe2_path}/src/${autofile}/${name}.${autofile}"])


  # MENU.iPXE Menu Entry
  #( pxe2/src/menu.ipxe ) 
  if ! defined (Concat::Fragment["menu.ipxe-${distro}.menu_entry"]) {
    concat::fragment { "menu.ipxe-${distro}.menu_entry":
      target  => "${pxe2_path}/src/menu.ipxe",
      content => template('pxe2_ipxe_menus/02.linux.menu.ipxe.erb'),
      order   => 30,
    }
  }
  # BOOT.CFG Menu Entry
  #( pxe2/src/boot.cfg ) 
  if ! defined (Concat::Fragment["boot.cfg-${distro}.mirror_entry"]) {
    concat::fragment { "boot.cfg-${distro}.mirror_entry":
      target  => "${pxe2_path}/src/boot.cfg",
      content => template('pxe2_ipxe_menus/02.mirrors.boot.cfg.erb'),
      order   => 30,
    }
  }

  # pxe2/README.md
  if ! defined (Concat::Fragment["README.md-os-${name}"]) {
    concat::fragment{"README.md-os-${name}":
      target  => "${pxe2_path}/README.md",
      content => template('pxe2_ipxe_menus/02.os.README.md.erb'),
      order   => 02,
    }
  }

  # pxe2/src/linux.ipxe
  if ! defined (Concat::Fragment["linux.ipxe-${distro}"]) {
    concat::fragment{"linux.ipxe-${distro}":
      target  => "${pxe2_path}/src/linux.ipxe",
      content => template('pxe2_ipxe_menus/02.linux.menu.ipxe.erb'),
      order   => 02,
    }
  }
  # distro.ipxe
  if ! defined (Concat["${pxe2_path}/src/${distro}.ipxe"]) {
    concat{"${pxe2_path}/src/${distro}.ipxe":
      mode => '0777',
      require => File["${pxe2_path}/src"],
    } notice("${pxe2_path}/src/${distro}.ipxe")
  }
  if ! defined (Concat::Fragment["${distro}.ipxe-header"]) {
    concat::fragment{"${distro}.ipxe-header":
      target  => "${pxe2_path}/src/${distro}.ipxe",
      content => template('pxe2_ipxe_menus/01.header.distro.ipxe.erb'),
      order   => 01,
    } notice("${distro}.ipxe-header")
  }
  if ! defined (Concat::Fragment["${distro}.ipxe-distro.${name}"]) {
    concat::fragment{"${distro}.ipxe-distro.${name}":
      target  => "${pxe2_path}/src/${distro}.ipxe",
      content => template('pxe2_ipxe_menus/02.distro.ipxe.erb'),
      order   => 50,
    } notice("${distro}.ipxe-distro")
  }
  if ! defined (Concat::Fragment["${distro}.ipxe-footer"]) {
    concat::fragment{"${distro}.ipxe-footer":
      target  => "${pxe2_path}/src/${distro}.ipxe",
      content => template('pxe2_ipxe_menus/03.footer.distro.ipxe.erb'),
      order   => 99,
    } notice("${distro}.ipxe-footer")
  }
  # name.ipxe
  file { "${name}.ipxe":
    ensure  => file,
    path    => "${pxe2_path}/src/${name}.ipxe",
    content => template("pxe2_ipxe_menus/manual_install.ipxe.erb"),
    require => File[ "${pxe2_path}/src" ],
  } notice(File["${pxe2_path}/src/${name}.ipxe"])

}
