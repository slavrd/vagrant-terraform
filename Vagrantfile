Vagrant.configure("2") do |config|

  # set default terraform version
  tf_ver = "0.12.2"
  if ENV["tf_ver"] != nil && ENV["tf_ver"] != ""
    tf_ver = ENV["tf_ver"]
  end

  config.vm.box = "slavrd/xenial64"
  config.vm.provision "shell",
    inline: "sudo apt-get update >>/dev/null && sudo apt-get install -y curl vim git >>/dev/null"

  config.vm.provision "shell",
    inline: "curl -sSf -o /tmp/tf_install.sh https://raw.githubusercontent.com/slavrd/bash-various-scripts/master/install_hc_product.sh \
            && bash /tmp/tf_install.sh terraform #{tf_ver} linux amd64"

  if FileTest.exist?("#{ENV["HOME"]}/.terraformrc")
    config.vm.provision "file", source: "~/.terraformrc", destination: ".terraformrc"
  end

  if FileTest.exist?("#{ENV["HOME"]}/.aws/credentials")
    config.vm.provision "shell", inline: "[ ! -d /home/vagrant/.aws ] && mkdir /home/vagrant/.aws && chown vagrant:vagrant /home/vagrant/.aws"
    config.vm.provision "file", source: "#{ENV["HOME"]}/.aws/credentials", destination: "/home/vagrant/.aws/credentials"
  end
           
end
