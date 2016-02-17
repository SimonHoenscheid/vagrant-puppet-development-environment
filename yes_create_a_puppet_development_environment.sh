#!/bin/bash

if [ -f Vagrantfile ]; then
rm Vagrantfile
fi

echo 'Please Enter the Puppetversion you want to use. Type 4 for Puppet4 and 3 for Puppet3'
read PUPPETVERSION

if [ "$PUPPETVERSION" == "3" ]; then
  echo "I will build a Puppet development environment for Puppet3"
	cp VagrantfileV3 Vagrantfile
fi

if [ "$PUPPETVERSION" == "4" ]; then
  echo "I will build a Puppet development environment for Puppet4"
	cp VagrantfileV4 Vagrantfile
fi

echo "doing first vagrant run"
vagrant up
echo "doing second vagrant run"
vagrant up
echo "doing third vagrant run"
vagrant up
echo "puppet never runs completely trouble less when setting up a multi node puppetdb setup"

if [ "$PUPPETVERSION" == "3" ]; then
vagrant ssh puppet -c 'sudo puppet agent -t --server puppet.local'
vagrant ssh puppet -c 'sudo puppet agent -t --server puppet.local'
vagrant ssh puppetdb -c 'sudo puppet agent -t --server puppet.local'
vagrant ssh postgres-puppetdb -c 'sudo puppet agent -t --server puppet.local'
fi

if [ "$PUPPETVERSION" == "4" ]; then
vagrant ssh puppet -c 'sudo /opt/puppetlabs/bin/puppet agent -t --server puppet.local'
vagrant ssh puppet -c 'sudo /opt/puppetlabs/bin/puppet agent -t --server puppet.local'
vagrant ssh puppetdb -c 'sudo /opt/puppetlabs/bin/puppet agent -t --server puppet.local'
vagrant ssh postgres-puppetdb -c 'sudo /opt/puppetlabs/bin/puppet agent -t --server puppet.local'
fi
