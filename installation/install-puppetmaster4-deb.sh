#!/bin/bash

# Prepare puppetlabs repo
CODENAME=`lsb_release -cs`

echo "install puppetlabs repository"
wget http://apt.puppetlabs.com/puppetlabs-release-pc1-"$CODENAME".deb
dpkg -i puppetlabs-release-pc1-"$CODENAME".deb
apt-get update

echo "Install Puppetserver"
apt-get install -y puppetserver
rm -f puppetlabs-release-pc1-"$CODENAME".deb

echo "update System"
sudo apt-get update
sudo apt-get dist-upgrade -Vy
sudo service puppetserver restart

echo "cleanup CA"
sudo service puppetserver stop
sudo rm -rf /etc/puppetlabs/puppet/ssl/*
sudo service puppetserver start

echo "disable agent, start puppetserver and enable start on boot"
# Disable Puppet agent on systemd
# PuppetLabs has the service disabled per default
if which systemctl >/dev/null; then
  systemctl stop puppet
  systemctl disable puppet
  systemctl start puppetserver
  systemctl enable puppetserver
fi

echo "install deepmerge gem"
sudo su puppet -s /bin/bash -c '/opt/puppetlabs/bin/puppetserver gem install deep_merge'
sudo /opt/puppetlabs/puppet/bin/gem install deep_merge

echo "install hiera-eyaml-gpg and dependencies"
sudo su puppet -s /bin/bash -c '/opt/puppetlabs/bin/puppetserver gem install ruby_gpg highline trollop'
sudo su puppet -s /bin/bash -c '/opt/puppetlabs/bin/puppetserver gem install hiera-eyaml hiera-eyaml-gpg'
sudo /opt/puppetlabs/puppet/bin/gem install ruby_gpg highline trollop
sudo /opt/puppetlabs/puppet/bin/gem install hiera-eyaml hiera-eyaml-gpg

if [ -f /vagrant/puppetmaster.gpg.sec ]; then
	#import private key for puppetmaster without password
	sudo cp /vagrant/puppetmaster.gpg.sec /opt/puppetlabs/server/data/puppetserver/key
	sudo chown puppet:puppet /opt/puppetlabs/server/data/puppetserver/key
	sudo su puppet -s /bin/bash -c '/usr/bin/gpg --import /opt/puppetlabs/server/data/puppetserver/key'
fi

echo "set autosigning for *.local domain"
sudo echo '*.local' > /etc/puppetlabs/puppet/autosign.conf
sudo service puppetserver restart

echo "apply puppetmaster role"
sudo /opt/puppetlabs/bin/puppet apply --hiera_config=/vagrant/puppet4/hieradata/hiera.yaml --modulepath=/vagrant/puppet4/modules -e'include site_module::roles::single_puppetmaster'

echo "first run on the puppetserver"
sudo /opt/puppetlabs/bin/puppet agent -t --server puppet.local

echo "restart puppetserver"
sudo service puppetserver restart
