# Vagrant xenial64 with Terraform

A vagrant project that builds a virtual box machine with xenial64 OS and terraform and some basic tools installed.

## Prerequisites

* Install VirtualBox - [instructions](https://www.virtualbox.org/wiki/Downloads)
* Install Vagrant - [instructions](https://www.vagrantup.com/downloads.html)

## Run

* Set terraform version to env variable `tf_ver` e.g. `tf_ver=0.11.14`
* Build machine - `vagrant up`
* Destroy machine - `vagrant destroy`

In case the `tf_ver` env variable is not set the Vagrant project is set to default to ver 0.12.2

If the user has configured TF CLI `~/.terraformrc` and/or AWS credentials file `~/.aws/credentials` they will also be copied to the VM
