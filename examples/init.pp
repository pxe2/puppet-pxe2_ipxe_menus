if $virtual == 'docker' {
  include dummy_service
}

class{'pxe2_ipxe_menus': }
pxe2_ipxe_menus::linux_menu{'rancheros-1.4.0-amd64':}
