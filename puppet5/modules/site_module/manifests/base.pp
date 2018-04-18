#lowest productive class of the site module, this is where the role assignment happens, roles always bundle profiles
class site_module::base (
  $server_role = $site_module::params::server_role,
  $server_stage = $site_module::params::server_stage,
){
  include site_module::params
  include "site_module::roles::${server_role}"
}
