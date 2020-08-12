generate_key_for_openvpn_client:
  cmd.run:
    - name: ./easyrsa gen-req {{ pillar['hostname'] }} nopass
    - cwd: /etc/openvpn/easy-rsa

sign_key_for_openvpn_client_using_ca_cert:
  cmd.run:
    - name: ./easyrsa sign-req client {{ pillar['hostname'] }}
    - cwd: /etc/openvpn/easy-rsa

verify_openvpn_client_key:
  cmd.run:
    - name: openssl verify -CAfile pki/ca.crt pki/issued/{{ pillar['hostname'] }}.crt
    - cwd: /etc/openvpn/easy-rsa

get_ca_crt:
  module.run:
    - name: cp.push
    - path: /etc/openvpn/easy-rsa/pki/ca.crt
    - upload_path: /etc/openvpn/client/ca.crt

get_client_crt:
  module.run:
    - name: cp.push
    - path: /etc/openvpn/easy-rsa/pki/issued/{{ pillar['hostname'] }}.crt
    - upload_path: /etc/openvpn/client/{{ pillar['hostname'] }}.crt

get_client_key:
  module.run:
    - name: cp.push
    - path: /etc/openvpn/easy-rsa/pki/private/{{ pillar['hostname'] }}.key
    - upload_path: /etc/openvpn/client/{{ pillar['hostname'] }}.key
