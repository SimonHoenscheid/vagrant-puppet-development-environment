#puppetmaster profile
class site_module::profiles::puppetdb_postgres (
  $postgres_listen_address = hiera('site_module::profiles::puppetdb_postgres::postgres_listen_address', undef),
){
  
  class { 'puppetdb::database::postgresql':
    listen_addresses => $postgres_listen_address,
  }

}
