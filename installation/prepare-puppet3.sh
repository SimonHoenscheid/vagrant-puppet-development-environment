#!/bin/bash

sudo echo 'deb http://apt.puppetlabs.com stable main' > /etc/apt/sources.list.d/puppetlabs.list
sudo echo 'deb-src http://apt.puppetlabs.com stable main' >> /etc/apt/sources.list.d/puppetlabs.list
sudo apt-get update
sudo apt-get dist-upgrade -y
sudo apt-get -fy install
