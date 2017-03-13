#!/bin/sh

pushd $(dirname $0)

ansible-galaxy install -r ./requirements.yml -p ./vendor_roles
ansible-playbook ./site.yml $@
