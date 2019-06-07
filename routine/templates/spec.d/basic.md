## Basics

- System vendor: {{ ansible_system_vendor }}
- BIOS: {{ ansible_bios_version }} : {{ ansible_bios_date }}
- Kernel: {{ ansible_kernel }}
- OS : {{ ansible_system }}
  - Distribution: {{ ansible_distribution }} {{ ansible_distribution_version }}
  - release version: {{ ansible_distribution_release }}
  - Major version: {{ ansible_distribution_major_version }}
- Hostname: {{ inventory_hostname }}
- Uptime: {{ ansible_uptime_seconds / 60 / 60}} (hours)
- SELinux: {{ ansible_selinux.config | default('disabled') }}

