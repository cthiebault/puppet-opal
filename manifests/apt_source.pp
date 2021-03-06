class opal::apt_source {

  $repo_release = $opal::stable ? {
    true   => 'stable',
    default => 'unstable',
  }

  class { 'apt': }

#  TODO: use apt::source instead of adding it manually
#  apt::source { "obiba.$repo_release":
#    location    => 'http://pkg.obiba.org',
#    release     => "$repo_release/",
#    repos       => '',
#    include_src => false,
#    architecture => false,
#  }

  exec { 'wget -q -O - http://pkg.obiba.org/obiba.org.key | sudo apt-key add -':
    path => ['/usr/bin', '/usr/sbin'],
    require  => Package['wget'],
  }

# https://github.com/puppetlabs/puppetlabs-stdlib
  file_line { "obiba-${repo_release}-sources.list":
    path    => '/etc/apt/sources.list',
    line    => "deb http://pkg.obiba.org ${repo_release}/",
    notify  => Exec['apt_update']
  }

}