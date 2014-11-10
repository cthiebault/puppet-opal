class opal::mysql (
  $mysql_user,
  $mysql_password,
) {

  class { '::mysql::server':
    override_options => {
      'mysqld' => {
        'default-storage-engine' => 'INNODB',
        'innodb_file_per_table' => true,
        'init_connect' => 'SET collation_connection = utf8_bin',
        'init_connect' => 'SET NAMES utf8',
        'character-set-server' => 'utf8',
        'collation-server' => 'utf8_bin',
        'skip-character-set-client-handshake' => true,
        'max_allowed_packet' => '1G',
      }
    }
  }

  mysql::db { 'opal_data':
    user     => $mysql_user,
    password => $mysql_password,
    host     => 'localhost',
    grant    => 'ALL',
    charset  => 'utf8',
    collate  => 'utf8_bin',
  }

  mysql::db { 'opal_ids':
    user     => $mysql_user,
    password => $mysql_password,
    host     => 'localhost',
    grant    => 'ALL',
    charset  => 'utf8',
    collate  => 'utf8_bin',
  }

}