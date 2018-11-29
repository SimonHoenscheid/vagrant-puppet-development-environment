#single postgres database for puppetdb
class site_module::roles::postgres_puppetdb (){
  include site_module::profiles::puppetdb_postgres
}
