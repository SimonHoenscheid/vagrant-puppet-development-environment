#Vagrant Puppet Development Environment

##Why

**Reproducible** Development Environment for Puppet

##What

* Puppet4 Support
* Puppet3 Support

## MASTERS
* Debian 8 based


## OS IMAGES AVAILABLE FOR CLIENTS

* Debian 7
* Debian 8
* Centos 6
* Centos 7
* Oracle Enterprise linux 6
* Oracle Enterprise linux 7
* Ubuntu 12.04 LTS
* Ubuntu 14.04 LTS
* Ubuntu 16.04 LTS

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
	
Add up to five clients.

	* puppetclient-{01-05}.local (puppet agent)

##Get Startet

	* clone the repository
	* if you want/need hiera-eyaml-gpg support, place a private puppetmaster gpg 
	  key without passphrase inside the vagrant directory, name it
	  puppetmaster.gpg.sec, it will be importet, dependencies will be installed
	* edit Vagrantfile{V3,V4} in line 25/26, set this to the pwd
	* run yes_create_a_puppet_development_environment.sh
	* decide which version and clients you need, the environment will be build
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
	
	./cleanup_all_vagrantboxes.sh
**connect to a vagrant box**

	vagrant ssh *boxname*

**connect different OS Clients to puppetmaster**

1. go to clients directory
2. choose the OS with the matching puppet version (p3 =Puppet3, p4=Puppet4)
3. boxes puppetclient0{1-5} are prepared for each OS.
4. execute vagrant global-status
5. start up the next box in a row:
6. vagrant up puppetclient0n

##TODO

* get rid of puppet deprecation warnings for the Puppet3 agents (roll out new config)
* setup puppetexplorer node
* setup foreman node (will not work with Puppet 4 atm)
* cleanup code
* do more things in puppetcode, less in scripts


##FIXED
* fix the puppetmaster -> puppetdb communication bug with Puppet3 [Bug] (https://github.com/SimonHoenscheid/vagrant-puppet-development-environment/issues/1)

