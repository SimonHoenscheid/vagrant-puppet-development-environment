#parameters
class site_module::params (){
     $split_puppetversion = split($::puppetversion, '[.]')
     $major_puppetversion = $split_puppetversion[0]
     $minor_puppetversion = $split_puppetversion[1]
}
