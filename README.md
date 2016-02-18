#Vagrant Puppet Development Environment

##Why

**Reproducible** Development Environment for Puppet

##What

* Puppet4 Support
* Puppet3 Support (not yet, see Issues)

##Requirements

* vagrant-hosts

		vagrant plugin install vagrant-hosts
* vagrant
* virtual box
* 3-5 GB of RAM

Setup a four node Puppet Environment:
	
	* puppet.local (puppetmaster/puppetserver)
	* puppetdb.local (puppetdb)
	* postgres-puppetdb.local (postgresql database)
	* puppetclient-01.local (puppet agent)

##Get Startet

	* clone the repository
	* if you want/need hiera-eyaml-gpg support, place a private puppetmaster gpg 
	  key without password inside the vagrant directory, name it
	  puppetmaster.gpg.sec, it will be importet, dependencies will be installed
	* run yes_create_a_puppet_development_environment.sh
	* decide which version you need, the environment will be build
	* you can just start coding within the puppet directories located in the
	  vagrant directory. You could also move the existing code to an new git
	  repo, remove the symlinks in the environment dir and modify the vagrant
	  file to mount your new git.
##Transfer existing Code to new Git and mounting
**transfer the existing code to new git**

	cd ~/
	mkdir new-puppet-dev
	cd new-puppet-dev
	git init 
	cp -r /path/to/vagrant/git/hieradata .
	cp -r /path/to/vagrant/git/manifests .
	cp -r /path/to/vagrant/git/modules .

**delete existing symlinks in vagrant box**

	vagrant ssh puppet
	sudo rm -rf /path/to/puppet/environment/directory/*
	logout
**edit Vagrantfile add the following line to the puppet host**

	
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

* fix the puppetmaster -> puppetdb communication bug with Puppet3 [Bug] (https://github.com/SimonHoenscheid/vagrant-puppet-development-environment/issues/1)
* get rid of puppet deprecation warnings for the Puppet3 agents (roll out new config)
* add CENT OS 7 support
* setup puppetexplorer node
* setup foreman node (will not work with Puppet 4 atm)
* cleanup code
* do more things in puppetcode, less in scripts

