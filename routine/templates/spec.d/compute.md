## Compute

- CPU:
  - Model: {{ ansible_processor | unique | join(' ') }}
  - vcpus: {{ ansible_processor_vcpus }}
- Memory: {{ ansible_memtotal_mb }} (MB)

