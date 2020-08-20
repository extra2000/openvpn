{% if not salt['file.directory_exists' ]('/etc/openvpn/client.conf') %}
/etc/openvpn/client.conf:
  file.managed:
    - source: salt://openvpn/client.conf.jinja
    - template: jinja
{% endif %}
