class opal::data {

  opal::data::import { 'idsdb' : }
  opal::data::import { 'sqldb' : }
  opal::data::import { 'mongodb' : }

}

define opal::data::import (
  $password = $opal::params::password,
) {

  $json = template("${module_name}/${name}.json.erb")
  exec { "import-${name}-db":
    provider => shell,
    command  => "opal rest -o http://localhost:8080 -u administrator -p ${password} -m POST /system/databases --content-type \"application/json\" < ${json}",
    require  => [Package['opal'], Package['opal-python-client']],
  }

}

