class opal::datashield {

  package { 'opal-rserver' :
    ensure  => 'latest',
    require => Package['opal'],
  }

  include opal::datashield::rstudio

  service { 'rserver' :
    ensure  => 'running',
    require => Package['opal-rserver'],
  }

  user { 'datashield':
    ensure    => 'present',
    password  => $opal::password,
  }

}

# TODO look for RStudio puppet module
class opal::datashield::rstudio {

  apt::source { 'rstudio':
    location   => 'http://cran.rstudio.com/bin/linux/ubuntu',
  # release    => 'precise',
    key        => 'E084DAB9',
    key_server => 'keyserver.ubuntu.com',
  }

  $tmp_rstudio = "/tmp/${opal::rstudio_deb}"

  package { ['libapparmor1', 'gdebi-core', 'r-base']  :
    ensure  => 'latest',
  }
  ->
  wget::fetch { 'rstudio-server-download':
    require     => Package['r-base'],
    timeout     => 0,
    destination => $tmp_rstudio,
    source      => "http://download2.rstudio.org/${opal::rstudio_deb}",
  }
  ->
  exec { 'rstudio-server-install':
    provider => shell,
    command  => "gdebi -n ${tmp_rstudio}",
  }
  ->
  file { $tmp_rstudio:
    ensure => absent
  }
  ->
  file { '/etc/init.d/rstudio-server':
    source => '/usr/lib/rstudio-server/extras/init.d/debian/rstudio-server'
  }
#  ->
#  exec {
#    command => 'update-rc.d rstudio-server defaults',
#    path    => ['/bin', '/usr/bin', '/usr/sbin'],
#  }
}