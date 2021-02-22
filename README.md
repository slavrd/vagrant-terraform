# Vagrant Ubuntu with Terraform

A vagrant project that builds a virtual box machine with Ubuntu OS and terraform and some basic tools installed.

Optionally `mitmproxy` can be set up to allow inspection of the terraform HTTP requests.

## Prerequisites

* Install VirtualBox - [instructions](https://www.virtualbox.org/wiki/Downloads)
* Install Vagrant - [instructions](https://www.vagrantup.com/downloads.html)

## Run

* Set terraform version to env variable `tf_ver` e.g. `tf_ver=0.11.14`
* Build machine - `vagrant up`
* Destroy machine - `vagrant destroy`

In case the `tf_ver` env variable is not set the Vagrant project is set to default to the value set for the variable `tf_ver` in the Vagrantfile.

If the user has configured TF CLI `~/.terraformrc` and/or AWS credentials file `~/.aws/credentials` they will also be copied to the VM

## Examples

* Build a VM with specified TF version:

```Bash
tf_ver=0.11.14 vagrant up # build VM
vagrant ssh  # login to VM
cd /vagrant # on VM, go to the VM <-> HOST synced folder
```

* Change the TF version without rebuilding the VM

```Bash
tf_ver=0.12.2 vagrant provision # will re-run all provisioning
```

* Destroy VM

```Bash
vagrant destroy -f # does not prompt for confirmation
```

## Mitmproxy

Mitmproxy can be set up to inspect the HTTP requests made by Terraform. It is installed by running an additional vagrant provisioner.

```bash
vagrant provision --provision-with mitmproxy
```

This will install the mitmproxy, set up CA certificate and start the web interface on port `8081` which is forwarded to the host machine.

To access the mitmproxy open `http://localhost:8081` in the browser on your host machine.
