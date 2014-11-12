class opal inherits opal::params {

  include wget

#  class { 'java':
#    distribution => 'jre',
#  }

  include ::mongodb::server

  include opal::mysql

  include opal::apt_source

  include opal::server

#  include opal::datashield
#
#  include opal::data

}