#!/bin/sh

backup_files=".ssh"

pushd /
tar cJvf /vagrant/vagrant_ssh_$(date +%Y%m%d%M%S).tar.xz home/vagrant/${backup_files}
