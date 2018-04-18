#!/bin/bash
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
