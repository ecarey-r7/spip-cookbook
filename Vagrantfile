# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure('2') do |config|
  config.berkshelf.enabled = true
  config.omnibus.chef_version = :latest
  config.ssh.max_tries = 40
  config.ssh.timeout   = 120
end

vagrantfiles = %w[vagrant/Vagrantfile.fedora vagrant/Vagrantfile.ubuntu]
vagrantfiles.each do |vagrantfile|
  load File.expand_path(vagrantfile) if File.exists?(vagrantfile)
end
