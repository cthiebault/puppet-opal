class opal::datashield (
  $rstudio_deb  = $opal::params::rstudio_deb,
  $password     = $opal::params::datashield_password,
) {

  apt::source { 'rstudio':
    location   => 'http://cran.rstudio.com/bin/linux/ubuntu',
  # release    => 'precise',
    key        => 'E084DAB9',
    key_server => 'keyserver.ubuntu.com',
  }

  package { 'opal-rserver' :
    ensure  => 'latest',
    require => Package['opal'],
  }

  service { 'rserver' :
    ensure  => 'running',
    require => Package['opal-rserver'],
  }

# R studio
  package { ['libapparmor1', 'gdebi-core']  :
    ensure  => 'latest',
  }
  ->
  wget::fetch { 'rstudio-server-download':
    require     => Package['r-base'],
    timeout     => 0,
    destination => $rstudio_deb,
    source      => "http://download2.rstudio.org/${rstudio_deb}",
  }
  ->
  exec { 'rstudio-server-install':
    provider => shell,
    command  => "gdebi -n ${rstudio_deb}",
  }
  ->
  file { $rstudio_deb:
    ensure => absent
  }
  ->
  file { '/etc/init.d/rstudio-server':
    source => '/usr/lib/rstudio-server/extras/init.d/debian/rstudio-server'
  }
  ->
  exec {
    command => 'update-rc.d rstudio-server defaults',
  }

  user { 'datashield':
    ensure    => 'present',
    password  => $password,
  }

}