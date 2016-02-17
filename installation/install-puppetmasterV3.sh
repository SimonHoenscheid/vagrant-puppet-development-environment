#!/bin/bash

sudo apt-get install -y ruby ruby-dev
sudo gem install deep_merge

if [ -f /vagrant/puppetmaster.gpg.sec ]; then
	#install hiera-eyaml-gpg and dependencies
	gem install hiera-eyaml-gpg gpgme
	#import private key for puppetmaster without password
	sudo su puppet -s /bin/bash -c '/usr/bin/gpg --import /vagrant/puppetmaster.gpg.sec'
fi
sudo service puppetmaster stop
sudo rm -rf /var/lib/puppet/ssl/*
sudo mkdir -p /etc/puppet/environments/production
sudo service puppetmaster start
sudo ln -s /vagrant/hieradata /etc/puppet/environments/production/
sudo ln -s /vagrant/manifests /etc/puppet/environments/production/
sudo ln -s /vagrant/modules /etc/puppet/environments/production/
puppet agent --enable
sudo puppet apply --hiera_config=/vagrant/hieradata/hiera.yaml --modulepath=/vagrant/modules -e'include site_module::roles::single_puppetmaster'
sudo service puppetmaster restart
sudo service puppetqd restart
sleep 5
