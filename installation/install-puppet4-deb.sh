#!/bin/bash

# Prepare puppetlabs repo
CODENAME=`lsb_release -cs`

wget http://apt.puppetlabs.com/puppetlabs-release-pc1-"$CODENAME".deb
dpkg -i puppetlabs-release-pc1-"$CODENAME".deb
apt-get update

# Install puppet/facter
apt-get install -y puppet-agent
rm -f puppetlabs-release-pc1-"$CODENAME".deb

# Disable Puppet agent on systemd
# PuppetLabs has the service disabled per default
if which systemctl >/dev/null; then
  systemctl stop puppet
  systemctl disable puppet
fi

sudo /opt/puppetlabs/bin/puppet agent -t --server puppet.local 
