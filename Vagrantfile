# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  os = "bento/ubuntu-18.04"
  net_ip = "192.168.50"

  # import the box once and then create references for all other instaces
  #config.linked_clone = true

  config.vm.define :master, primary: true do |master_config|
    master_config.vm.provider "virtualbox" do |vb|
        vb.linked_clone = true
        vb.memory = "2048"
        vb.cpus = 1
        vb.name = "master"
        #fix ubuntu netwrok issue https://stackoverflow.com/questions/18457306/how-to-enable-internet-access-inside-vagrant
        vb.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
        vb.customize ["modifyvm", :id, "--natdnsproxy1", "on"]
        end
    
    master_config.vm.box = "#{os}"
    master_config.vm.host_name = 'master'
    master_config.vm.network "private_network", ip: "#{net_ip}.10"

    master_config.vm.synced_folder "saltstack/salt/", "/srv/salt"
    master_config.vm.synced_folder "saltstack/pillar/", "/srv/pillar"
    #master_config.vm.synced_folder "saltstack/etc/master.d/", "/etc/salt/master.d"
    
    # fix for salt /bin/sh vs. /usr/bin/sh issue
    master_config.vm.provision "shell",
      inline: "ln -sf /bin/sh /usr/bin/sh"

    master_config.vm.provision :salt do |salt|
      salt.master_config = "saltstack/etc/master"
      salt.master_key = "saltstack/keys/master.pem"
      salt.master_pub = "saltstack/keys/master.pub"
      salt.seed_master = {
                          "minion1" => "saltstack/keys/minion1.pub",
                          "minion2" => "saltstack/keys/minion2.pub"
                         }

      salt.install_type = "stable"
      salt.install_master = true

      salt.minion_config = "saltstack/etc/minion_generic.yaml"
      salt.no_minion = false

      salt.verbose = true
      salt.colorize = true
      salt.python_version = "3"

      salt.bootstrap_options = "-P -c /tmp"
    end
  end


  [
    ["minion1",  "#{net_ip}.11", "512", os ],
    ["minion2", "#{net_ip}.12", "512", os ],
    ["minion3", "#{net_ip}.13", "512", os ],
    ["minion4", "#{net_ip}.14", "512", os ],
  ].each do |vmname,ip,mem,os|
    config.vm.define "#{vmname}" do |minion_config|
      minion_config.vm.provider "virtualbox" do |vb|
          vb.linked_clone = true
          vb.memory = "#{mem}"
          vb.cpus = 1
          vb.name = "#{vmname}"
          #fix ubuntu network issue https://stackoverflow.com/questions/18457306/how-to-enable-internet-access-inside-vagrant
          vb.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
          vb.customize ["modifyvm", :id, "--natdnsproxy1", "on"]          
      end

      minion_config.vm.box = "#{os}"
      minion_config.vm.hostname = "#{vmname}"
      minion_config.vm.network "private_network", ip: "#{ip}"
      # fix for salt /bin/sh vs. /usr/bin/sh issue
      minion_config.vm.provision "shell",
        inline: "ln -sf /bin/sh /usr/bin/sh"

      minion_config.vm.provision :salt do |salt|
        salt.minion_config = "saltstack/etc/#{vmname}"
        salt.minion_key = "saltstack/keys/#{vmname}.pem"
        salt.minion_pub = "saltstack/keys/#{vmname}.pub"
        salt.install_type = "stable"
        salt.verbose = true
        salt.colorize = true
		    salt.python_version = "3"
        salt.bootstrap_options = "-P -c /tmp"
      end
    end
  end


  # Test for using the same key for multipe minions
  [
    ["minion5",  "#{net_ip}.15", "512", os ],
    ["minion6", "#{net_ip}.16", "512", os ],
  ].each do |vmname,ip,mem,os|
    config.vm.define "#{vmname}" do |minion_config|
      minion_config.vm.provider "virtualbox" do |vb|
          vb.linked_clone = true
          vb.memory = "#{mem}"
          vb.cpus = 1
          vb.name = "#{vmname}"
          #fix ubuntu network issue https://stackoverflow.com/questions/18457306/how-to-enable-internet-access-inside-vagrant
          vb.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
          vb.customize ["modifyvm", :id, "--natdnsproxy1", "on"]          
      end

      minion_config.vm.box = "#{os}"
      minion_config.vm.hostname = "#{vmname}"
      minion_config.vm.network "private_network", ip: "#{ip}"
      # fix for salt /bin/sh vs. /usr/bin/sh issue
      minion_config.vm.provision "shell",
        inline: "ln -sf /bin/sh /usr/bin/sh"

      minion_config.vm.provision :salt do |salt|
        salt.minion_config = "saltstack/etc/minion_generic.yaml"
        # provisioning without pki, then the minions createing certificates by their own
        #salt.minion_key = "saltstack/keys/minion_generic.pem"
        #salt.minion_pub = "saltstack/keys/minion_generic.pub"
        salt.install_type = "stable"
        salt.verbose = true
        salt.colorize = true
		    salt.python_version = "3"
        salt.bootstrap_options = "-P -c /tmp"
      end
    end
  end
end