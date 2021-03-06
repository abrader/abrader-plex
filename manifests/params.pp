class plex::params (
  $version = '0.9.11.5.774-760cb52',
  $stage_dir = "/tmp/staging",
) {
  $server_pkg_url = "https://downloads.plex.tv/plex-media-server/${version}"

  case $::osfamily {
    'RedHat': {
      $server_pkg_name = "plexmediaserver-${version}.${::architecture}.rpm"
      $package_provider = 'rpm'
      $server_pkg_prereqs = []
      $server_svc_name = "plexmediaserver"
    }
    'Suse': {
      $server_pkg_name = "plexmediaserver-${version}.${::architecture}.rpm"
      $package_provider = 'rpm'
      $server_pkg_prereqs = []
      $server_svc_name = "plexmediaserver"
    }
    'Debian': {
       $server_pkg_name = "plexmediaserver_${version}_${::architecture}.deb"
       $package_provider = 'dpkg'
       $server_pkg_prereqs = [ 'avahi-daemon', 'avahi-utils' ]
       $server_svc_name = "plexmediaserver"
    }
    default: {
      fail("Unsupported platform: abrader-${module_name} currently doesn't support ${::osfamily} or ${::operatingsystem}")
    }
  }
}
