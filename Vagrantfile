install_deps = <<-SCRIPT
sudo apt-get update
sudo apt-get install -y openjdk-17-jdk
SCRIPT

Vagrant.configure("2") do |config|
  config.vm.define "softserve_devops_vm1" do |config|
    config.vm.box = "ubuntu/bionic64"
    config.vm.provider "virtualbox" do |v|
      v.name = "softserve_devops_vm1"
      v.cpus = 2
      v.memory = 4096
    end
    
    config.vm.hostname = "vm1" 
    config.vm.network "private_network", ip: "192.168.10.10", netmask: "255.255.255.0"
    config.vm.network "forwarded_port", guest: 22, host: 2222, id: 'ssh'
    
    config.vm.synced_folder "./vagrant_sync_folder", "/vagrant"
    
    config.vm.provision "shell", inline: install_deps
    config.vm.provision "shell", inline: "cat /vagrant/id_rsa.pub >> /home/vagrant/.ssh/authorized_keys"
  end
end