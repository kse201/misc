#  {{ ansible_hostname }} Facts
date: {# '%Y-%m-%d %H:%M:%S' | strftime #} {# ansible v2.4 #}

## Highlight

- Hostname: {{ ansible_hostname }}
- OS: {{ ansible_distribution }} {{ ansible_distribution_version }}
- IP address: {{ ansible_ssh_host }}
- ID/PASS: {{ ansible_ssh_user }}/{{ ansible_ssh_pass | default('nil') }}
- description:
  {{ description | default('') }}

{% include './spec.d/basic.md'%}

{% include './spec.d/compute.md'%}

{% include './spec.d/network.md'%}

{% include './spec.d/storage.md'%}

{% include './spec.d/misc.md'%}