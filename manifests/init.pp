class opal (
  $stable = true,
  $mysql_user = 'opaluser',
  $mysql_password = 'opalpass',
) {


#  class { 'java':
#    distribution => 'jre',
#  }
#

  include '::mongodb::server'

  class { 'opal::mysql':
    mysql_user     => $mysql_user,
    mysql_password => $mysql_password,
  }

  class { 'opal::apt_source':
    stable => $stable,
  }

  package { 'opal' :
    ensure  => 'latest',
    require => Exec['apt_update'],
  }

}