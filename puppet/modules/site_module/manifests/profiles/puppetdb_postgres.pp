#puppetmaster profile
class site_module::profiles::puppetdb_postgres (
  $postgres_listen_address = $site_module::params::postgres_listen_address,
){
  class { 'puppetdb::database::postgresql':
    listen_addresses => $postgres_listen_address,
  }
}
