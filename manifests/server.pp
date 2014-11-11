class opal::server (
  $password = $opal::params::password,
) {

# TODO: manage password like puppet-mysql does

  package { "debconf-utils":
    ensure => installed
  }

  exec { 'set-opal-password':
    command => "/bin/echo opal opal-server/admin_password select ${password} | debconf-set-selections",
    path    => ['/bin', '/usr/bin'],
    require => Package['debconf-utils'],
  }

  exec { 'repeat-opal-password':
    command => "/bin/echo opal opal-server/admin_password_again select ${password} | debconf-set-selections",
    path    => ['/bin', '/usr/bin'],
    require => [Package['debconf-utils'], Exec['set-opal-password']],
  }

  package { 'opal' :
    ensure  => 'latest',
    require => [Exec['apt_update'], Exec['repeat-opal-password']],
  }

  package { 'opal-python-client' :
    ensure  => 'latest',
    require => Package['opal'],
  }

}