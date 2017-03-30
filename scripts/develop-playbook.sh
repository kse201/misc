#!/bin/sh

cat <<'...' > ansible.cfg
[defaults]
inventory=inventory.ini
roles_path=~/.ghq/github.com/kse201
...

cat <<'...' > inventory.ini
[defaults]
localhost ansible_connection=local
...

cat <<'...' > run-ansible.sh
#!/bin/sh

ansible-playbook ./site.yml $@
...

chmod +x run-ansible.sh

cat <<'...' > site.yml
---
- hosts: localhost
  vars: []
  roles:
    - role: ansible-dotfiles
    - role: ansible-base
  become: false
...
