{% if not salt['file.directory_exists' ]('/etc/openvpn/server.conf') %}
/etc/openvpn/server.conf:
  file.managed:
    - source: salt://openvpn/server.conf.jinja
    - template: jinja
{% endif %}
