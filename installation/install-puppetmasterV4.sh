#!/bin/bash

sudo su puppet -s /bin/bash -c '/opt/puppetlabs/bin/puppetserver gem install deep_merge'
sudo /opt/puppetlabs/puppet/bin/gem install deep_merge
if [ -f /vagrant/puppetmaster.gpg.sec ]; then
	#install hiera-eyaml-gpg and dependencies
  sudo su puppet -s /bin/bash -c '/opt/puppetlabs/bin/puppetserver gem install ruby_gpg highline trollop'
  sudo su puppet -s /bin/bash -c '/opt/puppetlabs/bin/puppetserver gem install hiera-eyaml hiera-eyaml-gpg'
	sudo /opt/puppetlabs/puppet/bin/gem install ruby_gpg highline trollop
	sudo /opt/puppetlabs/puppet/bin/gem install hiera-eyaml hiera-eyaml-gpg
	#import private key for puppetmaster without password
	sudo su puppet -s /bin/bash -c '/usr/bin/gpg --import /vagrant/puppetmaster.gpg.sec'
fi
sudo service puppetserver stop
sudo rm -rf /etc/puppetlabs/puppet/ssl/*
sudo rm -rf /etc/puppetlabs/code/environments/production/*
sudo service puppetserver start
sudo /opt/puppetlabs/bin/puppet apply --hiera_config=/vagrant/puppet/hieradata/hiera.yaml --modulepath=/vagrant/puppet/modules -e'include site_module::roles::single_puppetmaster'
