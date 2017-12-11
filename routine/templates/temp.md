
- partitions:

mount_points | mount | filesystem | size
filesystem | Size    | Used         | Avail | Use% | Mount on| type
-----------|---------|--------------|-------|------|---------|---
{% for moutn_point,params in facter_mountpoints %}
{{ params.device }}  | {{ params.size }} | {{ params.used}} | {{ params.available }} | {{ params.capacity }} | {{ mount_points }} | {{ params.filesystem }}

{% endfor %}

