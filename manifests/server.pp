class plex::server (
  $version = $plex::params::version,
) inherits plex::params {

  $stagedir = "/tmp/staging"

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

  class {'staging' :
    path  => $stagedir,
    owner => 'root',
    group => 'root',
  }

  staging::file { $package_name :
    source => "https://downloads.plex.tv/${module_name}-media-server/${version}/${package_name}",
  }

  package { $package_prereqs :
    ensure => present,
  }

  package { "${module_name}mediaserver" :
    ensure   => present,
    source   => "${stagedir}/${module_name}/${package_name}",
    provider => $package_provider,
    require  => [ Staging::File[$package_name], Package[$package_prereqs] ],
  }

}
