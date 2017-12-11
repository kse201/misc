## Network

- FQDN: {{ ansible_fqdn }}
- DNS: 
  - nameservers: {{ ansible_dns.nameservers }}
  - serarch : {{ ansible_dns.search | default('') }}
- Interfaces: 

| device | type | active | macaddress | pciid | module | IP address |
|--------|------|--------|------------|-------|--------|------------|
{% for interface in ansible_interfaces | sort() %}
{% set fact = "ansible_" + interface | regex_replace('-', '_') %}
{% set params = hostvars[host][fact] %}
| {{ params.device }} | {{ params.type }} | {{ params.active }} | {{ params.macaddress | default('') }} | {{ params.pciid | default('') }} | {{ params.module | default('') }} | {% if params.ipv4 is defined %}{{ params.ipv4.address | default ('') }}{% endif %} |
{% endfor %}
