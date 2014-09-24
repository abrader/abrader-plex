class plex::server (
  $version = $plex::params::version,
) inherits plex::params {

  $stagedir = "/tmp/staging"

  if $::osfamily != 'RedHat' {
    fail("Unsupported platform: abrader-${module_name} currently doesn't support ${::osfamily} or ${::operatingsystem}")
  }

  class {'staging' :
    path  => $stagedir,
    owner => 'root',
    group => 'root',
  }

  staging::file { "${module_name}mediaserver-${version}.${::architecture}.rpm" :
    source => "https://downloads.plex.tv/${module_name}-media-server/${version}/${module_name}mediaserver-${version}.${architecture}.rpm",
  }

  package { "${module_name}mediaserver" :
    ensure   => $version,
    source   => "${stagedir}/${module_name}/${module_name}mediaserver-${version}.${::architecture}.rpm", 
    provider => 'rpm',
    require  => Staging::File["${module_name}mediaserver-${version}.${::architecture}.rpm"],
  }

}
