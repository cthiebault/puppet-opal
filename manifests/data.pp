class opal::data (
  $password = $opal::params::password,
) {

  $idsdb = template("${module_name}/idsdb.json.erb")
  exec { 'import-ids-db':
    provider => shell,
    command  => "opal rest -o http://localhost:8080 -u administrator -p ${password} -m POST /system/databases --content-type \"application/json\" < ${idsdb}",
    require  => [Package['opal'], Package['opal-python-client']],
  }

  $sqldb = template("${module_name}/sqldb.json.erb")
  exec { 'import-sql-db':
    provider => shell,
    command  => "opal rest -o http://localhost:8080 -u administrator -p ${password} -m POST /system/databases --content-type \"application/json\" < ${sqldb}",
    require  => [Package['opal'], Package['opal-python-client']],
  }

  $mongodb = template("${module_name}/mongodb.json.erb")
  exec { 'import-ids-db':
    provider => shell,
    command  => "opal rest -o http://localhost:8080 -u administrator -p ${password} -m POST /system/databases --content-type \"application/json\" < ${mongodb}",
    require  => [Package['opal'], Package['opal-python-client']],
  }

}