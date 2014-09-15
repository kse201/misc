# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  if Vagrant.has_plugin?("vagrant-proxyconf")
    config.proxy.http     = ENV['http_proxy']
    config.proxy.https    = ENV['https_proxy']
    config.proxy.no_proxy = ENV['no_proxy']
  end
  config.vm.box = "opscode_centos-6.5"
  config.vm.box_url = "http://opscode-vm-bento.s3.amazonaws.com/vagrant/virtualbox/opscode_centos-6.5_chef-provisionerless.box"
  config.vm.network :private_network, ip: "192.168.33.10"

  config.vm.synced_folder "./export", "/export"

  config.omnibus.chef_version  =  :latest
  config.vm.provision :chef_solo do |chef| 
    chef.cookbooks_path = [ "./cookbooks", ".site-cookbooks" ]
    chef.json = {
        vim: {
            install_method: "source"
        }
    }
    chef.run_list = %w[
      recipe[yum] 
      recipe[yum-epel] 
      recipe[vim]
      recipe[git]
      recipe[zsh]
    ]
  end
end
