#Vagrant Puppet Development Environment

##Why

**Reproducible** Development Environment for Puppet

##What

* Puppet4 Support
* Puppet3 Support

##Requirements

* vagrant-hosts

		vagrant plugin install vagrant-hosts
		
* vagrant
* virtual box
* 3-5 GB of RAM

Setup a Puppet Environment:
	
	* puppet.local (puppetmaster/puppetserver)
	* puppetdb.local (puppetdb)
	* postgres-puppetdb.local (postgresql database)
	
Add up to five clients. While the master nodes are debian 8, the clients can be debian{7,8}, centos(6,7), oracle linux {6,7}, ubuntu{12 LTS, 14 LTS, 16 LTS} 

	* puppetclient-{01-05}.local (puppet agent)

##Get Startet

	* clone the repository
	* if you want/need hiera-eyaml-gpg support, place a private puppetmaster gpg 
	  key without passphrase inside the vagrant directory, name it
	  puppetmaster.gpg.sec, it will be importet, dependencies will be installed
	* edit Vagrantfile{V3,V4} in line 25/26, set this to the pwd
	* run yes_create_a_puppet_development_environment.sh
	* decide which version you need, the environment will be build
	* you can just start coding within the puppet directories located in the
	  vagrant directory. You could also move the existing code to an new git
	  repo and modify the vagrant
	  file to mount your new git.
##Transfer existing Code to new Git and mounting
**transfer the existing code to new git**

	cd ~/
	mkdir new-puppet-dev
	cd new-puppet-dev
	git init 
	cp -r /path/to/vagrant/puppet/hieradata .
	cp -r /path/to/vagrant/puppet/manifests .
	cp -r /path/to/vagrant/puppet/modules .

**edit Vagrantfile edit the following line to the puppet host (Line 25 [V4]/line 26 [V3])**

	
	puppet.vm.synced_folder "/path/to/local/git", "/path/to/puppet/environment/directory"

**reload vagrant**

	vagrant reload
	
##Basic Usage
**start an environment**

	./yes_create_a_puppet_development_environment.sh
**stop an environment**

	vagrant halt
**destroy an environment**
	
	vagrant destroy -f
**connect to a vagrant box**

	vagrant ssh *boxname*

**connect a new box to the puppetmaster**

1. add new hostname and ip to hostlist on top of vagrant file
2. copy the block of the puppetclient01 node and edit the ip and name
3. safe the vagrant file
4. execute vagrant up
5. the box ist connected, happy development

##TODO

* get rid of puppet deprecation warnings for the Puppet3 agents (roll out new config)
* add multi OS Support
* setup puppetexplorer node
* setup foreman node (will not work with Puppet 4 atm)
* cleanup code
* do more things in puppetcode, less in scripts

##FIXED
* fix the puppetmaster -> puppetdb communication bug with Puppet3 [Bug] (https://github.com/SimonHoenscheid/vagrant-puppet-development-environment/issues/1)

