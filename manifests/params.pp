class plex::params {
  $version = '0.9.10.1.585-f31034e'
  #$version = '0.9.9.14.531-7eef8c6'

  $stage_dir = "/tmp/staging"

  case $::osfamily {
    'RedHat': {
      $package_name = "${module_name}mediaserver-${version}.${::architecture}.rpm"
      $package_provider = 'rpm'
      $package_prereqs = []
    }
    'Debian': {
      $package_name = "${module_name}mediaserver_${version}_${::architecture}.deb"
      $package_provider = 'dpkg'
      $package_prereqs = [ 'libnss-mdns', 'avahi-daemon', 'avahi-utils', 'libavahi-common3', 'libavahi-core7', 'libdaemon0', 'dbus', 'libdbus-1-3', 'libsystemd-login0' ]
    }
    default: {
      fail("Unsupported platform: abrader-${module_name} currently doesn't support ${::osfamily} or ${::operatingsystem}")
    }
  }
}
