#!/bin/bash

if [ -f Vagrantfile ]; then
rm Vagrantfile
fi

d7='Debian 7'
d8='Debian 8'
c7='CentOS 7'
c6='CentOS 6'
ora6='Oracle Linux 6'
ora7='Oracle Linux 7'
u12='Ubuntu 1204 LTS'
u14='Ubuntu 1404 LTS'
u16='Ubuntu 1604 LTS'

echo 'Please Enter the Puppetversion you want to use. Type 4 for Puppet4 and 3 for Puppet3'
#add input validation
read PUPPETVERSION

echo 'Please Enter the OS you want to use on the clientside. Type' 
echo 'd8 for Debian 8'
echo 'd7 for Debian 7'
echo 'c7 for CentOS 7'
echo 'c6 for CentOS 6'
echo 'ora7 for Oracle Linux 7'
echo 'ora6 for Oracle Linux 6'
echo 'u12 for Ubuntu 1204 LTS'
echo 'u14 for Ubuntu 1404 LTS'
echo 'u16 for Ubuntu 1604 LTS'
#add input validation
read OS


echo 'Please Enter the number of clients you want to create. possible 1-5'
#add input validation
read NUMBER_OF_PUPPETCLIENTS

if [ "$PUPPETVERSION" == "3" ]; then
  echo "I will build a Puppet development environment for Puppet3 with $NUMBER_OF_PUPPETCLIENTS clients on ${!OS}"
	cp VagrantfileV3 Vagrantfile
fi

if [ "$PUPPETVERSION" == "4" ]; then
  echo "I will build a Puppet development environment for Puppet4  with $NUMBER_OF_PUPPETCLIENTS clients on ${!OS}"
	cp VagrantfileV4 Vagrantfile
fi

echo "doing first vagrant run"
vagrant up
echo "doing second vagrant run"
vagrant up
echo "doing third vagrant run"
vagrant up
echo "puppet never runs completely trouble less when setting up a multi node puppetdb setup"

vagrant ssh puppet -c 'sudo puppet agent -t --server puppet.local'
vagrant ssh puppet -c 'sudo puppet agent -t --server puppet.local'
vagrant ssh puppetdb -c 'sudo puppet agent -t --server puppet.local'
vagrant ssh postgres-puppetdb -c 'sudo puppet agent -t --server puppet.local'
cd clients/$OSp$PUPPETVERSION
for (( i=1; i<=$NUMBER_OF_PUPPETCLIENTS; i++ ))
do
   echo "building puppetclient 0$i with ${!OS}"
   vagrant up puppetclient0$i
done
