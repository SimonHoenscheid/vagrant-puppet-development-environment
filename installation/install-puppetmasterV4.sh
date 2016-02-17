#!/bin/bash

sudo /opt/puppetlabs/bin/puppetserver gem install deep_merge

if [ -f /vagrant/puppetmaster.gpg.sec ]; then
	#install hiera-eyaml-gpg and dependencies
	sudo /opt/puppetlabs/bin/puppetserver gem install ruby_gpg
	sudo /opt/puppetlabs/bin/puppetserver gem install hiera-eyaml-gpg
	#import private key for puppetmaster without password
	sudo su puppet -s /bin/bash -c '/usr/bin/gpg --import /vagrant/puppetmaster.gpg.sec'
fi
sudo service puppetserver stop
sudo rm -rf /etc/puppetlabs/puppet/ssl/*
sudo rm -rf /etc/puppetlabs/code/environments/production/*
sudo service puppetserver start
sudo ln -s /vagrant/hieradata /etc/puppetlabs/code/environments/production/
sudo ln -s /vagrant/manifests /etc/puppetlabs/code/environments/production/
sudo ln -s /vagrant/modules /etc/puppetlabs/code/environments/production/
sudo /opt/puppetlabs/bin/puppet apply --hiera_config=/vagrant/hieradata/hiera.yaml --modulepath=/vagrant/modules -e'include site_module::roles::single_puppetmaster'
