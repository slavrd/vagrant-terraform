#!/usr/bin/env bash
# Installs and configures mitmproxy for 'vagrant' user.
# Needs to be run as the vagrant user

set -exo pipefail

which mitmproxy && {
    echo "mitmproxy is already installed"
    exit 0
}

sudo apt-get update
sudo apt-get install -y python3-pip

# Installatoin of mitmproxy on bionic seem to require installing the python dependencies explicitly.
sudo python3 -m pip install mitmproxy
# sudo apt-get install -y mitmproxy

# start the mitmproxy so it generates the SSL certificates
export LANG=en_US.UTF-8
[ -d /home/vagrant/.mitmproxy/ ] || mkdir /home/vagrant/.mitmproxy/
mitmweb --web-host '*' 2>&1>/home/vagrant/.mitmproxy/log.txt &
sleep 5

# add mitmproxy CA certificate to the trusted root CAs
sudo cp /home/vagrant/.mitmproxy/mitmproxy-ca-cert.cer /usr/local/share/ca-certificates/mitmproxy-ca-cert.crt
sudo update-ca-certificates

# add proxy enironment variables for vagrant user
echo 'export HTTP_PROXY=127.0.0.1:8080' | tee -a /home/vagrant/.profile
echo 'export HTTPS_PROXY=127.0.0.1:8080' | tee -a /home/vagrant/.profile