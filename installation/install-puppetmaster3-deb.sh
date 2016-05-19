#!/bin/bash

# Prepare puppetlabs repo
CODENAME=`lsb_release -cs`

wget http://apt.puppetlabs.com/puppetlabs-release-"$CODENAME".deb
dpkg -i puppetlabs-release-"$CODENAME".deb
sed -i s/jessie/stable/g /etc/apt/sources.list.d/puppetlabs.list
apt-get update

# Install puppet/facter
apt-get install -y puppet puppetmaster 
rm -f puppetlabs-release-"$CODENAME".deb

# Disable Puppet agent on systemd
# PuppetLabs has the service disabled per default
if which systemctl >/dev/null; then
  systemctl stop puppet
  systemctl disable puppet
  systemctl start puppetmaster
  systemctl enable puppetmaster
fi

sudo apt-get install -y ruby ruby-dev
sudo gem install deep_merge

echo "install hiera-eyaml-gpg and dependencies"
gem install hiera-eyaml-gpg gpgme
#import private key for puppetmaster without password

if [ -f /vagrant/puppetmaster.gpg.sec ]; then
	sudo su puppet -s /bin/bash -c '/usr/bin/gpg --import /vagrant/puppetmaster.gpg.sec'
fi

sudo service puppetmaster stop
sudo rm -rf /var/lib/puppet/ssl/*
sudo mkdir -p /etc/puppet/environments/production
sudo service puppetmaster start
puppet agent --enable
sudo puppet apply --hiera_config=/vagrant/puppet3/hieradata/hiera.yaml --modulepath=/vagrant/puppet3/modules -e'include site_module::roles::single_puppetmaster'
sudo service puppetmaster restart
sudo service puppetqd restart
sleep 5
