class plex::params {
  $version = '0.9.10.1.585-f31034e'
  #$version = '0.9.9.14.531-7eef8c6'

  $stage_dir = "/tmp/staging"

  case $::osfamily {
    'RedHat': {
      $server_pkg_name = "${module_name}mediaserver-${version}.${::architecture}.rpm"
      $package_provider = 'rpm'
      $server_pkg_prereqs = []
    }
    'Debian': {
       $server_pkg_name = "${module_name}mediaserver_${version}_${::architecture}.deb"
       $package_provider = 'dpkg'
       $server_pkg_prereqs = [ 'avahi-daemon', 'avahi-utils' ]
    }
    default: {
      fail("Unsupported platform: abrader-${module_name} currently doesn't support ${::osfamily} or ${::operatingsystem}")
    }
  }
}
