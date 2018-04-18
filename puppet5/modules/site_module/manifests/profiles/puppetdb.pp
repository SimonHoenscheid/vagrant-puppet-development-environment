#puppetdb profile
class site_module::profiles::puppetdb (
  $major_puppetversion       = $site_module::major_puppetversion,
  $puppetdb_java_args        = $site_module::puppetdb_java_args,
  $puppetdb_listen_address   = $site_module::puppetdb_listen_address,
  $puppetdb_postgres_address = $site_module::puppetdb_postgres_address,
  ){
  if $major_puppetversion == '3' {
    class { '::puppetdb::globals':
      version => '2.3.4-1puppetlabs1',
    }
  }
  class { '::puppetdb::server':
    database_host      => $puppetdb_postgres_address,
    listen_address     => $puppetdb_listen_address,
    ssl_listen_address => $puppetdb_listen_address,
    java_args          => $puppetdb_java_args,
  }
}
