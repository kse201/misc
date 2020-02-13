# -*- mode: ruby -*-
# vi: set ft=ruby :

require 'json'
# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = '2'

json_config = JSON.load File.read('config.json')
userdata = File.read('userdata')

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  ssh_username = 'ec2-user'

  config.vm.box = 'dummy'
  config.vm.box_url = 'https://github.com/mitchellh/vagrant-aws/raw/master/dummy.box'

  config.vm.provider :aws do |aws, override|
    aws.aws_dir = ENV['HOME'] + "/.aws/"
    aws.aws_profile = json_config['profile']['value']
    aws.keypair_name              = json_config['keypair_name']['value']
    override.ssh.username         = ssh_username
    # override.ssh.private_key_path = json_config['private_key_path']['value']
    override.ssh.private_key_path = "/Users/keise/.ssh/id_rsa"
    # aws.private_ip_address = ''

    aws.region = json_config['region']['value']
    aws.elastic_ip = false
    aws.subnet_id = json_config['subnet_id']['value']
    aws.security_groups = json_config['sec_group_id']['value']

    # aws.tags = json_config['tags']
    aws.ami = json_config['amazonlinux_ami_id']['value']
    aws.instance_type = json_config['instance_type']['value']

    # config.ssh.proxy_command = '' # FIXME
    # config.ssh.forward_agent
    # config.ssh.forward_env
    # config.ssh.keep_alive
  end

  config.vm.synced_folder '.', '/vagrant', disabled: true

  config.vm.provision :shell, privileged: true, inline: userdata
end
