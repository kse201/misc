## Storage

| device | model | size | partition |
|--------|-------|------|-----------|
{% for device in ansible_devices | sort() %}
{% set params = ansible_devices[device] %}
| {{ device }} | {{ params.model }} | {{ params.size }} | |
{% for part, part_params in params.partitions | dictsort %}
| - | - | ( {{ part_params.size }} )| {{ part }} |
{% endfor %}
{% endfor %}
