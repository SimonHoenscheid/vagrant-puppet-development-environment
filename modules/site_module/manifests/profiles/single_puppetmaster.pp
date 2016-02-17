#single puppetmaster profile
class site_module::profiles::single_puppetmaster (
  $puppetdb_address    = hiera('site_module::profiles::single_puppetmaster::puppetdb_address', undef),
  $puppet_config_path  = $settings::confdir,
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
    ensure => present,
    owner  => 'root',
    group  => 'root',
    mode   => '0644',
    source => "puppet:///modules/site_module/profiles/puppetmaster/hiera.${major_puppetversion}.yaml",
  }
  file{ "${puppet_config_path}/autosign.conf":
    ensure => present,
    owner  => 'root',
    group  => 'root',
    mode   => '0644',
    source => 'puppet:///modules/site_module/profiles/puppetmaster/autosign.conf',
  }

}
