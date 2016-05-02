#single puppetmaster profile
class site_module::profiles::single_puppetmaster (
  $puppetdb_address    = $site_module::params::puppetdb_address,
  $use_hiera_eyaml_gpg = $site_module::params::use_hiera_eyaml_gpg,
  $puppet_config_path  = $site_module::params::puppet_config_path,
  $major_puppetversion = $site_module::params::major_puppetversion,
  $hiera_config        = $site_module::params::hiera_config,
  $hiera_templatefile  = $site_module::params::hiera_templatefile,
  $terminus_package    = $site_module::params::terminus_package,
){

  class{ 'puppetdb::master::config':
    puppetdb_server             => $puppetdb_address,
    terminus_package            => $terminus_package,
    puppetdb_soft_write_failure => true,
  }

  if $major_puppetversion == '3' {
    file{ "${puppet_config_path}/puppet.conf":
      ensure => file,
      owner  => 'root',
      group  => 'root',
      mode   => '0644',
      source => "puppet:///modules/site_module/profiles/puppetmaster/puppet.${major_puppetversion}.conf",
    }
  }

  file{ $hiera_config:
    ensure  => file,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => template($hiera_templatefile),
  }

  file{ "${puppet_config_path}/autosign.conf":
    ensure => file,
    owner  => 'root',
    group  => 'root',
    mode   => '0644',
    source => 'puppet:///modules/site_module/profiles/puppetmaster/autosign.conf',
  }
}
