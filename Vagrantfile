Vagrant.configure("2") do |config|

  # set default terraform version
  tf_ver = "latest"
  if ENV["tf_ver"] != nil && ENV["tf_ver"] != ""
    tf_ver = ENV["tf_ver"]
  end

  config.vm.box = "slavrd/bionic64"

  config.vm.provider "virtualbox" do |v|
    v.memory = 2048
    v.cpus = 2
  end

  # forward mitmproxy web port to host
  config.vm.network "forwarded_port", guest: 8081, host: 8081

  config.vm.provision "shell",
    inline: "sudo apt-get update >>/dev/null && sudo apt-get install -y curl vim git >>/dev/null"

  config.vm.provision "shell",
    inline: "curl -sSf -o /tmp/tf_install.sh https://raw.githubusercontent.com/slavrd/bash-various-scripts/master/install_hc_product.sh \
            && bash /tmp/tf_install.sh terraform #{tf_ver} linux amd64"
  
  config.vm.provision "shell",
    inline: "grep 'complete -C .* terraform' /home/vagrant/.bashrc >>/dev/null || terraform -install-autocomplete", privileged: false

  # use the "--provion-with mitmproxy" flag ro run this.
  config.vm.provision "mitmproxy", type: "shell",
    path: "./scripts/install_mitmproxy.sh", privileged: false, run: "never"

  if FileTest.exist?("#{ENV["HOME"]}/.terraform.d/credentials.tfrc.json")
    config.vm.provision "shell", inline: "[ ! -d /home/vagrant/.terraform.d/ ] && mkdir /home/vagrant/.terraform.d/ && chown vagrant:vagrant /home/vagrant/.terraform.d/ || exit 0"
    config.vm.provision "file", source: "#{ENV["HOME"]}/.terraform.d/credentials.tfrc.json", destination: "/home/vagrant/.terraform.d/credentials.tfrc.json"
  elsif FileTest.exist?("#{ENV["HOME"]}/.terraformrc")
    config.vm.provision "file", source: "~/.terraformrc", destination: ".terraformrc"
  end

  if FileTest.exist?("#{ENV["HOME"]}/.aws/credentials")
    config.vm.provision "shell", inline: "[ ! -d /home/vagrant/.aws ] && mkdir /home/vagrant/.aws && chown vagrant:vagrant /home/vagrant/.aws || exit 0"
    config.vm.provision "file", source: "#{ENV["HOME"]}/.aws/credentials", destination: "/home/vagrant/.aws/credentials"
  end

  if FileTest.exist?("#{ENV["HOME"]}/.ssh/id_rsa")
    config.vm.provision "shell", inline: "[ ! -d /home/vagrant/.ssh/ ] && mkdir /home/vagrant/.ssh/ && chown vagrant:vagrant /home/vagrant/.ssh/ || exit 0"
    config.vm.provision "file", source: "#{ENV["HOME"]}/.ssh/id_rsa", destination: "/home/vagrant/.ssh/id_rsa"
  end
           
end
