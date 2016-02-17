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
	  
	  
##TODO

* fix the puppetmaster -> puppetdb communication bug with Puppet3 [Bug] (https://github.com/SimonHoenscheid/vagrant-puppet-development-environment)
* get rid of puppet deprecation warnings for the Puppet3 agents (roll out new config)
* setup puppetexplorer node
* setup foreman node (will not work with Puppet 4 atm)
* cleanup code

