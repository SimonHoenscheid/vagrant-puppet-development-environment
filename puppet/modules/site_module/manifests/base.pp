#lowest productive class of the site module, this is where the role assignment happens, roles always bundle profiles
class site_module::base (
  $server_role = hiera('site_module::base::server_role', 'undefined'),
  $server_stage = hiera('site_module::base::server_stage', $::environment),
){

  include "site_module::roles::${server_role}"
}
