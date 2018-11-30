#init class of site module, entrypoint loads base class
class site_module (
  $hiera_config              = '/etc/puppetlabs/code/hiera.yaml',
  $hiera_templatefile        = 'site_module/profiles/puppetmaster/hiera.5.yaml.erb',
  $postgres_listen_address   = hiera('site_module::profiles::puppetdb_postgres::postgres_listen_address', undef),
  $puppet_config_path        = $settings::confdir,
  $puppetdb_address          = hiera('site_module::profiles::single_puppetmaster::puppetdb_address', undef),
  $puppetdb_java_args        = hiera('site_module::profiles::puppetdb::puppetdb_java_args', {}),
  $puppetdb_listen_address   = hiera('site_module::profiles::puppetdb_listen_address', undef),
  $puppetdb_postgres_address = hiera('site_module::profiles::puppetdb::puppetdb_postgres_address', undef),
  $server_role               = hiera('site_module::base::server_role', 'undefined'),
  $server_stage              = hiera('site_module::base::server_stage', $::environment),
  $terminus_package          = 'puppetdb-termini',
  $use_hiera_eyaml_gpg       = hiera('site_module::profiles::single_puppetmaster::use_hiera_eyaml_gpg', false),
) {
  include ::site_module::base
}
