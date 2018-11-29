#!/bin/bash

# Prepare puppetlabs repo
CODENAME=`lsb_release -cs`

wget http://apt.puppetlabs.com/puppet5-release-"$CODENAME".deb
dpkg -i puppet5-release-"$CODENAME".deb
apt-get update

# Install puppet/facter
apt-get install -y puppet-agent
rm -f puppet5-release-"$CODENAME".deb

# Disable Puppet agent on systemd
# PuppetLabs has the service disabled per default
if which systemctl >/dev/null; then
  systemctl stop puppet
  systemctl disable puppet
fi

sudo /opt/puppetlabs/bin/puppet agent -t --server puppet.local 
