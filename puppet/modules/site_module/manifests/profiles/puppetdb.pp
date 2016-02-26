#puppetdb profile
class site_module::profiles::puppetdb (
  $puppetdb_postgres_address = hiera('site_module::profiles::puppetdb::puppetdb_postgres_address', undef),
  $puppetdb_listen_address   = hiera('site_module::profiles::puppetdb_listen_address', undef),
  $puppetdb_java_args        = hiera('site_module::profiles::puppetdb::puppetdb_java_args', {}),
  ){
  include site_module::params

  $major_puppetversion = $site_module::params::major_puppetversion

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
