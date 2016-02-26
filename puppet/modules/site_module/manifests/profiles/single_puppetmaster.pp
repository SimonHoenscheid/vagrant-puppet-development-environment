#single puppetmaster profile
class site_module::profiles::single_puppetmaster (
  $puppetdb_address    = hiera('site_module::profiles::single_puppetmaster::puppetdb_address', undef),
  $puppet_config_path  = $settings::confdir,
  $use_hiera_eyaml_gpg = hiera('site_module::profiles::single_puppetmaster::use_hiera_eyaml_gpg', false),
){
  include site_module::params
  $major_puppetversion = $site_module::params::major_puppetversion

  $hiera_path = $major_puppetversion ? {
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

  class{ 'puppetdb::master::config':
    puppetdb_server             => $puppetdb_address,
    terminus_package            => $terminus_package,
    puppetdb_soft_write_failure => true,
  }
  if $major_puppetversion == '3' {
    file{ "${puppet_config_path}/puppet.conf":
      ensure => present,
      owner  => 'root',
      group  => 'root',
      mode   => '0644',
      source => "puppet:///modules/site_module/profiles/puppetmaster/puppet.${major_puppetversion}.conf",
    }
  }

  file{ $hiera_path:
    ensure  => present,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => template($hiera_templatefile),
  }

  file{ "${puppet_config_path}/autosign.conf":
    ensure => present,
    owner  => 'root',
    group  => 'root',
    mode   => '0644',
    source => 'puppet:///modules/site_module/profiles/puppetmaster/autosign.conf',
  }

}
