# the undefined role, every new node without assigned role gets this one
class site_module::roles::undefined (){
  notify {'This Node has no role assigned yet':}
}
