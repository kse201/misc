#!/bin/sh

apt-get update -y
apt-get install -y sudo openssh-server curl lsb-release \
                   ruby1.9.1 ruby1.9.1-dev

apt-get install -y software-properties-common
apt-add-repository -y ppa:ansible/ansible
apt-get update -y
apt-get install -y ansible
