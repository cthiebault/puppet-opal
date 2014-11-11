class opal (
  $stable         = $opal::params::stable,
  $password       = $opal::params::password,
  $mysql_user     = $opal::params::mysql_user,
  $mysql_password = $opal::params::mysql_password,
) inherits opal::params {

  include wget

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

  class { 'opal::server':
    password => $password,
  }

  include 'opal::datashield'

  include 'opal::data'

}