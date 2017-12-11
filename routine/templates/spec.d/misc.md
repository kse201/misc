## Miscellaneous
- Virtualization: {{ ansible_virtualization_type }}:{{ ansible_virtualization_role }}
{% if facter_facterversion is defined %}
- facter version: {{ facter_facterversion }}
- is_virtual: {{ facter_virtual }}
- timezone: {{ facter_timezone }}
- puppet:
  - version: {{ facter_puppetversion }}
{% if facter_facterversion > "3" %}
- BIOS: {{ facter_dmi.bios.vendor }} {{ facter_dmi.bios.version }}
{% if facter_dmi.board is defined %}
- Board
  - manufacturer: {{ facter_dmi.board.manufacturer | default('')}}
  - product: {{ facter_dmi.board.product | default('') }}
  - serial_number: {{ facter_dmi.board.serial_number | default('') }}
{% endif %}
{% if facter_dmi.chassis is defined %}
- Chassis
  - {{ facter_dmi.chassis }}
{% endif %}
{% if facter_dmi.product is defined %}
- product:
  - name: {{ facter_dmi.product.name | default('') }}
  - serial_number: {{ facter_dmi.product.serial_number |default('') }}
  - uuid: {{ facter_dmi.product.uuid | default('') }}
{% endif %}
{% else %}
- BIOS: {{ facter_bios_vendor }} {{ facter_bios_version }}
- Board
  - manufacturer: {{ facter_boardmanufacturer | default('') }}
  - product: {{ facter_boardproductname | default('') }}
  - serial_number: {{ facter_boardserialnumber | default('') }}
- product:
  - name: {{ facter_productname | default ('') }}
  - serial_number: {{ facter_serialnumber | default('') }}
  - uuid: {{ facter_uuid }}
{% endif %}
{% endif %}
