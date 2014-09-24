class plex::server (
  $version = $plex::params::version,
  $stage_dir = $plex::params::stage_dir,
  $server_pkg_name = $plex::params::server_pkg_name,
  $server_pkg_prereqs = $plex::params::server_pkg_prereqs,
  $package_provider = $plex::params::package_provider,
) inherits plex::params {

  class {'staging' :
    path  => $stage_dir,
    owner => 'root',
    group => 'root',
  }

  staging::file { $server_pkg_name :
    source => "https://downloads.plex.tv/${module_name}-media-server/${version}/${server_pkg_name}",
  }

  package { $server_pkg_prereqs :
    ensure => present,
  }

  package { "${module_name}mediaserver" :
    ensure   => present,
    source   => "${stage_dir}/${module_name}/${server_pkg_name}",
    provider => $package_provider,
    require  => [ Staging::File[$server_pkg_name], Package[$server_pkg_prereqs] ],
  }

}
