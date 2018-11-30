#single puppetmaster profile
class site_module::profiles::single_puppetmaster (
  $hiera_config        = $site_module::hiera_config,
  $hiera_templatefile  = $site_module::hiera_templatefile,
  $puppet_config_path  = $site_module::puppet_config_path,
  $puppetdb_address    = $site_module::puppetdb_address,
  $terminus_package    = $site_module::terminus_package,
  $use_hiera_eyaml_gpg = $site_module::use_hiera_eyaml_gpg,
){
  class{ '::puppetdb::master::config':
    puppetdb_server             => $puppetdb_address,
    terminus_package            => $terminus_package,
    puppetdb_soft_write_failure => true,
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
