# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
	# allow hostname resolution
	config.vm.provision :hosts do |prov|
		prov.add_host '192.168.0.5', ['puppet.local']
		prov.add_host '192.168.0.6', ['puppetdb.local']
		prov.add_host '192.168.0.7', ['postgres-puppetdb.local']
		prov.add_host '192.168.0.8', ['puppetexplorer.local']
		prov.add_host '192.168.0.9', ['foreman.local']
		prov.add_host '192.168.0.10', ['puppetclient-01.local']
	end

	# puppet master node
  config.vm.define "puppet" do |puppet|
		puppet.vm.box = "SimonHoenscheid/debian8-puppet3-master"
		puppet.vm.box_url = "https://atlas.hashicorp.com/SimonHoenscheid/debian8-puppet3-master"
		puppet.vm.hostname = "puppet.local"
		puppet.vm.network "private_network", ip: "192.168.0.5"
		puppet.vm.provision :shell, :path => "installation/prepare-install.sh"
		puppet.vm.provision :shell, :path => "installation/prepare-puppet3.sh"
		puppet.vm.provision :shell, :path => "installation/install-puppetmasterV3.sh"
    puppet.vm.synced_folder "/Volumes/Daten/coderepositories/vagrant-puppet-development-environment/puppet", "/etc/puppet/environments/production"
		puppet.vm.provider "virtualbox" do |v|
			v.memory = 1024 
			v.cpus = 1
		end
	end

  # puppetdb postgres database node
  config.vm.define "postgres-puppetdb" do |postgres_puppetdb|
		postgres_puppetdb.vm.box = "SimonHoenscheid/debian8-puppet3"
		postgres_puppetdb.vm.box_url = "https://atlas.hashicorp.com/SimonHoenscheid/debian8-puppet3"
		postgres_puppetdb.vm.hostname = "postgres-puppetdb.local"
		postgres_puppetdb.vm.network "private_network", ip: "192.168.0.7"
		postgres_puppetdb.vm.provision :shell, :path => "installation/prepare-install.sh"
		postgres_puppetdb.vm.provision :shell, :path => "installation/prepare-puppet3.sh"
		postgres_puppetdb.vm.provision :shell, :path => "installation/install-puppetdb-postgresV3.sh"
		postgres_puppetdb.vm.provider "virtualbox" do |v|
			v.memory = 1024 
			v.cpus = 1
		end
	end

  # puppetdb api node
  config.vm.define "puppetdb" do |puppetdb|
		puppetdb.vm.box = "SimonHoenscheid/debian8-puppet3"
		puppetdb.vm.box_url = "https://atlas.hashicorp.com/SimonHoenscheid/debian8-puppet3"
		puppetdb.vm.hostname = "puppetdb.local"
		puppetdb.vm.network "private_network", ip: "192.168.0.6"
		puppetdb.vm.provision :shell, :path => "installation/prepare-install.sh"
		puppetdb.vm.provision :shell, :path => "installation/prepare-puppet3.sh"
		puppetdb.vm.provision :shell, :path => "installation/install-puppetdbV3.sh"
		puppetdb.vm.provider "virtualbox" do |v|
			v.memory = 1024 
			v.cpus = 1
		end
	end
  
  # puppetclient01 node
  config.vm.define "puppetclient01" do |pc01|
		pc01.vm.box = "SimonHoenscheid/debian8-puppet3"
		pc01.vm.box_url = "https://atlas.hashicorp.com/SimonHoenscheid/debian8-puppet3"
		pc01.vm.hostname = "puppetclient-01.local"
		pc01.vm.network "private_network", ip: "192.168.0.10"
		pc01.vm.provision :shell, :path => "installation/prepare-install.sh"
		pc01.vm.provision :shell, :path => "installation/prepare-puppet3.sh"
		pc01.vm.provision :shell, :path => "installation/install-puppetclientV3.sh"
		pc01.vm.provider "virtualbox" do |v|
			v.memory = 1024 
			v.cpus = 1
		end
	end

end
