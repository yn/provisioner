# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure(2) do |config|
  config.vm.box_url = "https://github.com/mitchellh/vagrant-aws/raw/master/dummy.box"
  config.vm.box = "dummy"
  config.ssh.username = "ubuntu"
  config.ssh.forward_agent = true
  config.ssh.private_key_path = "~/.ssh/id_rsa"
  config.vm.synced_folder ".", "/vagrant", disabled: true

  config.vm.provider :aws do |aws, override|
    override.nfs.functional = false
    aws.instance_type="m3.medium"
    aws.access_key_id = ENV["AWS_ACCESS_KEY_ID"]
    aws.secret_access_key = ENV["AWS_SECRET_ACCESS_KEY"]
    aws.security_groups = ENV["AWS_SECURITY_GROUPS"].split(",") if ENV["AWS_SECURITY_GROUPS"]
    aws.region = "us-west-2"
    aws.region_config "us-west-2" do |region|
      # region.ami = 'ami-355c5a05' hvm-instance trusty
      region.ami = 'ami-154a4a25' # hvm-instance vivid
      region.keypair_name = ENV["AWS_KEYPAIR_NAME"] if ENV["AWS_KEYPAIR_NAME"]
    end
  end

  config.vm.define "p1", primary: true
  config.vm.define "p2"

  config.vm.provision "ansible" do |ansible|
    ansible.verbose  = "vvvv"
    ansible.playbook = "playbook.yml"
    ansible.raw_arguments = ['-e pipelining=True']
    ansible.extra_vars = {
      ansible_connection: 'ssh',
      ansible_ssh_args: '-o ForwardAgent=yes'
    }
  end
end
