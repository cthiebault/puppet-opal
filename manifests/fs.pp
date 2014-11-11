class opal::fs {

  archive { 'opal-fs':
    ensure => present,
    url    => 'https://github.com/obiba/opal-home/archive/master.zip',
    target => '/tmp',
  }
  ->
  file { '/var/lib/opal/fs' :
    ensure  => directory,
    source  => '/tmp/opal-home-master/fs',
    owner   => 'opal',
    recurse => true,
  }
  ->
  file { ['/tmp/opal-home-master', '/tmp/master.zip']:
    ensure => absent
  }

}