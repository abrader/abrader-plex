class plex::server (
  $version = $plex::params::version,
  $stage_dir = $plex::params::stage_dir,
  $server_pkg_name = $plex::params::server_pkg_name,
  $server_pkg_prereqs = $plex::params::server_pkg_prereqs,
  $server_svc_name = $plex::params::server_svc_name,
  $package_provider = $plex::params::package_provider,
) inherits plex::params {

  notice("Server Package URL: ${server_pkg_url}/${server_pkg_name}")

  class { 'staging' :
    path  => $stage_dir,
    owner => 'root',
    group => 'root',
  }

  package { $server_pkg_prereqs :
    ensure => present,
  }

  staging::file { $server_pkg_name :
    source => "${server_pkg_url}/${server_pkg_name}",
    require => Package[$server_pkg_prereqs],
  }

  package { $server_pkg_name :
    ensure   => present,
    source   => "${stage_dir}/${module_name}/${server_pkg_name}",
    provider => $package_provider,
    require  => Staging::File[$server_pkg_name],
  }
  
  service { $server_svc_name :
    ensure => running,
    enable => true,
    require => Package[$server_pkg_name],
  }

}
