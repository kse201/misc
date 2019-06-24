#!/bin/sh

target='localhost'
inventory='inventory.ini'
config='ansible.cfg'
playbook='site.yml'
work_dir=$(mktemp -d)
trap 'rm -rf ${work_dir}' INT TERM
cd "$work_dir"

cat << ... > ${inventory}
[defaults]
${target} ansible_connection=local
...


cat << ... > "${config}"
[defaults]
inventory=${inventory}
roles_path=~/.ghq/github.com/kse201
retry_files_enabled=False
nocows=yes
...

cat << ... > "${playbook}"
---
- hosts: ${target}
  roles:
    - role: ansible-base
  become: false
...

ansible-playbook \
    ./"${playbook}" "$@"

