class opal::data {

  opal::data::import { 'idsdb' : }
  opal::data::import { 'sqldb' : }
  opal::data::import { 'mongodb' : }

  if $opal::import_fs {
    include opal::data::fs
  }

}

class opal::data::fs {

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

define opal::data::import {

  $json = template("${module_name}/${name}.json.erb")
  exec { "import-${name}-db":
    provider => shell,
    command  => "opal rest -o http://localhost:8080 -u administrator -p ${opal::password} -m POST /system/databases --content-type \"application/json\" < ${json}",
    require  => [Package['opal'], Package['opal-python-client']],
  }

}

