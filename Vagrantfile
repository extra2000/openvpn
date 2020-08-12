# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vagrant.plugins = ["vagrant-reload", "vagrant-scp"]
end

openvpn_saltmaster_vagrantfile = './vagrant/Vagrantfile.openvpn-saltmaster'
load openvpn_saltmaster_vagrantfile if File.exists?(openvpn_saltmaster_vagrantfile)

openvpn_server_box_vagrantfile = './vagrant/Vagrantfile.openvpn-server-box'
load openvpn_server_box_vagrantfile if File.exists?(openvpn_server_box_vagrantfile)

openvpn_client_box_vagrantfile = './vagrant/Vagrantfile.openvpn-client-box'
load openvpn_client_box_vagrantfile if File.exists?(openvpn_client_box_vagrantfile)
