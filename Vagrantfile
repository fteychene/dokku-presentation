Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/xenial64"

  config.vm.network "private_network", ip: "192.168.0.42"

  config.vm.provision "shell", path: "scripts/install_dokku.sh"
end
