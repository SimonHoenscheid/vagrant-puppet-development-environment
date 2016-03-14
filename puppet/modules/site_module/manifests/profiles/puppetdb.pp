#puppetdb profile
class site_module::profiles::puppetdb (
  $puppetdb_postgres_address = $site_module::params::puppetdb_postgres_address,
  $puppetdb_listen_address   = $site_module::params::puppetdb_listen_address,
  $puppetdb_java_args        = $site_module::params::puppetdb_java_args,
  $major_puppetversion       = $site_module::params::major_puppetversion
  ){

  if $major_puppetversion == '3' {
    class { 'puppetdb::globals':
      version => '2.3.4-1puppetlabs1',
    }
  }
  class { 'puppetdb::server':
    database_host      => $puppetdb_postgres_address,
    listen_address     => $puppetdb_listen_address,
    ssl_listen_address => $puppetdb_listen_address,
    java_args          => $puppetdb_java_args,
  }
}
