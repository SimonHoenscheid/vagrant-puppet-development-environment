#parameters
class site_module::params (){
    $split_puppetversion = split($::puppetversion, '[.]')
    $major_puppetversion = $split_puppetversion[0]
    $minor_puppetversion = $split_puppetversion[1]

    $server_role = hiera('site_module::base::server_role', 'undefined'),
    $server_stage = hiera('site_module::base::server_stage', $::environment),

    $postgres_listen_address = hiera('site_module::profiles::puppetdb_postgres::postgres_listen_address', undef)

    $puppetdb_postgres_address = hiera('site_module::profiles::puppetdb::puppetdb_postgres_address', undef),
    $puppetdb_listen_address   = hiera('site_module::profiles::puppetdb_listen_address', undef),
    $puppetdb_java_args        = hiera('site_module::profiles::puppetdb::puppetdb_java_args', {}),

    $puppetdb_address    = hiera('site_module::profiles::single_puppetmaster::puppetdb_address', undef),
    $use_hiera_eyaml_gpg = hiera('site_module::profiles::single_puppetmaster::use_hiera_eyaml_gpg', false),

    ## this comes directly from puppet
    $puppet_config_path  = $settings::confdir,

    $hiera_config = $major_puppetversion ? {
       '3' => '/etc/puppet/hiera.yaml',
       '4' => '/etc/puppetlabs/code/hiera.yaml',
    }
    $terminus_package = $major_puppetversion ? {
       '3' => 'puppetdb-terminus',
       '4' => 'puppetdb-termini',
    }
    $hiera_templatefile = $major_puppetversion ? {
       '3' => 'site_module/profiles/puppetmaster/hiera.3.yaml.erb',
       '4' => 'site_module/profiles/puppetmaster/hiera.4.yaml.erb',
    }
}
