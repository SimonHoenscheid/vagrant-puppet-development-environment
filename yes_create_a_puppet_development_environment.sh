#!/bin/bash

c6='CentOS 6'
c7='CentOS 7'
d8='Debian 8'
d9='Debian 9'
ora6='Oracle Linux 6'
ora7='Oracle Linux 7'
u14='Ubuntu 1404 LTS'
u16='Ubuntu 1604 LTS'
u18='Ubuntu 1804 LTS'

echo 'Please Enter the Puppetversion you want to use. Type 4 for Puppet4 and 5 for Puppet5'
#add input validation
read PUPPETVERSION

echo 'Please Enter the OS you want to use on the clientside. Type'
echo 'c6 for CentOS 6'
echo 'c7 for CentOS 7'
echo 'd8 for Debian 8'
echo 'd9 for Debian 9'
echo 'ora6 for Oracle Linux 6'
echo 'ora7 for Oracle Linux 7'
echo 'u14 for Ubuntu 1404 LTS'
echo 'u16 for Ubuntu 1604 LTS'
echo 'u18 for Ubuntu 1804 LTS'
#add input validation
read OS

echo 'Please Enter the number of clients you want to create. possible 1-5'
#add input validation
read NUMBER_OF_PUPPETCLIENTS

echo "deleting existing puppetmaster environment"
vagrant destroy -f

if [ -f Vagrantfile ]; then
rm Vagrantfile
fi

for  i in $(ls -1 clients/);
do
   echo "deleting all clients in $i"
   cd clients/$i
   if [ -f Vagrantfile ]; then
	   vagrant destroy -f
   fi
   cd ../..
done

if [ "$PUPPETVERSION" == "4" ]; then
  echo "I will build a Puppet development environment for Puppet4 with $NUMBER_OF_PUPPETCLIENTS clients on ${!OS}"
	cp VagrantfileV4 Vagrantfile
fi

if [ "$PUPPETVERSION" == "4" ]; then
  echo "I will build a Puppet development environment for Puppet5  with $NUMBER_OF_PUPPETCLIENTS clients on ${!OS}"
	cp VagrantfileV5 Vagrantfile
fi

echo "doing first vagrant run"
vagrant up
echo "doing second vagrant run"
vagrant up
echo "doing third vagrant run"
vagrant up
echo "puppet never runs completely trouble less when setting up a multi node puppetdb setup"

if [ "$PUPPETVERSION" == "4" ]; then
vagrant ssh puppet -c 'sudo puppet agent -t --server puppet.local'
vagrant ssh puppet -c 'sudo puppet agent -t --server puppet.local'
vagrant ssh puppetdb -c 'sudo puppet agent -t --server puppet.local'
vagrant ssh postgres-puppetdb -c 'sudo puppet agent -t --server puppet.local'
fi

if [ "$PUPPETVERSION" == "5" ]; then
vagrant ssh puppet -c 'sudo /opt/puppetlabs/bin/puppet agent -t --server puppet.local'
vagrant ssh puppet -c 'sudo /opt/puppetlabs/bin/puppet agent -t --server puppet.local'
vagrant ssh puppetdb -c 'sudo /opt/puppetlabs/bin/puppet agent -t --server puppet.local'
vagrant ssh postgres-puppetdb -c 'sudo /opt/puppetlabs/bin/puppet agent -t --server puppet.local'
fi

cd clients/"$OS"p"$PUPPETVERSION"
for (( i=1; i<=$NUMBER_OF_PUPPETCLIENTS; i++ ))
do
   echo "building puppetclient 0$i with ${!OS}"
   vagrant up puppetclient0$i
done
