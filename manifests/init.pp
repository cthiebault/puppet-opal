class opal (
  $mysql_user = 'opaluser',
  $mysql_password = 'opalpass',
) {

#  class { 'java':
#    distribution => 'jre',
#  }

  include '::mongodb::server'

  include 'opal::mysql'

}