class plex::server (
  $version = $plex::params::version,
  $stage_dir = $plex::params::stage_dir,
  $package_name = $plex::params::package_name,
  $pacakge_prereqs = $plex::params::package_prereqs,
  $package_provider = $plex::params::package_provider,
) inherits plex::params {

  class {'staging' :
    path  => $stage_dir,
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
    source   => "${stage_dir}/${module_name}/${package_name}",
    provider => $package_provider,
    require  => [ Staging::File[$package_name], Package[$package_prereqs] ],
  }

}
