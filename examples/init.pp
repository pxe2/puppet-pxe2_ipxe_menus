if $virtual == 'docker' {
  include dummy_service
}

class{'pxe2_ipxe_menus'}
