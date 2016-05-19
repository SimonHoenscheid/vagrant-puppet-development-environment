#!/bin/bash

# Prepare puppetlabs repo
CENTOS_RELEASE=$(rpm -qa \*-release | grep -Ei "oracle|redhat|centos" | cut -d"-" -f3)

sudo rpm -ivh https://yum.puppetlabs.com/puppetlabs-release-pc1-el-"$CENTOS_RELEASE".noarch.rpm
sudo yum update

# Install puppet/facter
sudo yum install -y puppet-agent

# Disable Puppet agent on systemd
# PuppetLabs has the service disabled per default
if which systemctl >/dev/null; then
  sudo systemctl stop puppet
  sudo systemctl disable puppet
fi

sudo /opt/puppetlabs/bin/puppet agent -t --server puppet.local 
