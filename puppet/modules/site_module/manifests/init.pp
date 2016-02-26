#init class of site module, entrypoint loads base class
class site_module (){
  include site_module::params
  include site_module::base
}
