class plex::server (
  $version = $plex::params::version,
) inherits plex::params {

  $stagedir = "/tmp/staging"

  case $::osfamily {
    'RedHat': {
      $package_name = "${module_name}mediaserver-${version}.${::architecture}.rpm"
      $package_provider = 'rpm'
    }
    'Debian': {
      $package_name = "${module_name}mediaserver_${version}_${::architecture}.deb"
      $package_provider = 'dpkg'

      package { 'avahi-daemon' :
        ensure => present,
      }

      package { 'avahi-utils' :
        ensure => present,
      }
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

  package { "${module_name}mediaserver" :
    ensure   => present,
    source   => "${stagedir}/${module_name}/${package_name}",
    provider => $package_provider,
    require  => Staging::File[$package_name],
  }

}
