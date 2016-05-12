#!/bin/bash

# Prepare puppetlabs repo
CODENAME=`lsb_release -cs`

wget http://apt.puppetlabs.com/puppetlabs-release-pc1-"$CODENAME".deb
dpkg -i puppetlabs-release-pc1-"$CODENAME".deb
apt-get update

# Install puppet/facter
apt-get install -y puppetserver
rm -f puppetlabs-release-pc1-"$CODENAME".deb
sudo service puppetserver stop
sudo rm -rf /etc/puppetlabs/puppet/ssl/*
sudo service puppetserver start

# Disable Puppet agent on systemd
# PuppetLabs has the service disabled per default
if which systemctl >/dev/null; then
  systemctl stop puppet
  systemctl disable puppet
  systemctl start puppetserver
  systemctl enable puppetserver
fi

sudo su puppet -s /bin/bash -c '/opt/puppetlabs/bin/puppetserver gem install deep_merge'
sudo /opt/puppetlabs/puppet/bin/gem install deep_merge
if [ -f /vagrant/puppetmaster.gpg.sec ]; then
	#install hiera-eyaml-gpg and dependencies
  sudo su puppet -s /bin/bash -c '/opt/puppetlabs/bin/puppetserver gem install ruby_gpg highline trollop'
  sudo su puppet -s /bin/bash -c '/opt/puppetlabs/bin/puppetserver gem install hiera-eyaml hiera-eyaml-gpg'
	sudo /opt/puppetlabs/puppet/bin/gem install ruby_gpg highline trollop
	sudo /opt/puppetlabs/puppet/bin/gem install hiera-eyaml hiera-eyaml-gpg
	#import private key for puppetmaster without password
	sudo cp /vagrant/puppetmaster.gpg.sec /opt/puppetlabs/server/data/puppetserver/key
	sudo chown puppet:puppet /opt/puppetlabs/server/data/puppetserver/key
	sudo su puppet -s /bin/bash -c '/usr/bin/gpg --import /opt/puppetlabs/server/data/puppetserver/key'
fi
sudo /opt/puppetlabs/bin/puppet apply --hiera_config=/vagrant/puppet/hieradata/hiera.yaml --modulepath=/vagrant/puppet/modules -e'include site_module::roles::single_puppetmaster'
