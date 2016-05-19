#init class of site module, entrypoint loads base class
class site_module (
  $hiera_config              = $site_module::params::hiera_config,
  $hiera_templatefile        = $site_module::params::hiera_templatefile,
  $major_puppetversion       = $site_module::params::major_puppetversion,
  $postgres_listen_address   = $site_module::params::postgres_listen_address,
  $puppet_config_path        = $site_module::params::puppet_config_path,
  $puppetdb_address          = $site_module::params::puppetdb_address,
  $puppetdb_java_args        = $site_module::params::puppetdb_java_args,
  $puppetdb_listen_address   = $site_module::params::puppetdb_listen_address,
  $puppetdb_postgres_address = $site_module::params::puppetdb_postgres_address,
  $server_role               = $site_module::params::server_role,
  $server_stage              = $site_module::params::server_stage,
  $terminus_package          = $site_module::params::terminus_package,
  $use_hiera_eyaml_gpg       = $site_module::params::use_hiera_eyaml_gpg,
) inherits ::site_module::params {
  include ::site_module::base
}
