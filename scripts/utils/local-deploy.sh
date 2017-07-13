#!/bin/sh

target='localhost'
inventory='inventory.ini'
config='ansible.cfg'
playbook='site.yml'

cat << ... > ${inventory}
[defaults]
${target} ansible_connection=local
...


cat << ... > "${config}"
[defaults]
inventory=${inventory}
roles_path=~/.ghq/github.com/kse201
retry_files_enabled=False
cow_selection = random
...

cat << ... > "${playbook}"
---
- hosts: ${target}
  roles:
    - role: ansible-base
  become: false
...

trap 'rm ${inventory} ${config} ${playbook}' 2

ansible-playbook \
    ./"${playbook}" "$@"

