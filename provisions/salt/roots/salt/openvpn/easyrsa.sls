easyrsa:
  archive.extracted:
    - name: /etc/openvpn
    - source: https://github.com/OpenVPN/easy-rsa/releases/download/v3.0.7/EasyRSA-3.0.7.tgz
    - skip_verify: true

/etc/openvpn/easy-rsa:
  file.symlink:
    - target: /etc/openvpn/EasyRSA-3.0.7
    - force: true

/etc/openvpn/easy-rsa/vars:
  file.managed:
    - source: salt://openvpn/vars.jinja
    - template: jinja
    - mode: 755

generate_pki:
  cmd.run:
    - name: ./easyrsa init-pki
    - cwd: /etc/openvpn/easy-rsa

build_ca:
  cmd.run:
    - name: ./easyrsa build-ca nopass
    - cwd: /etc/openvpn/easy-rsa

generate_diffie_hellman_key:
  cmd.run:
    - name: ./easyrsa gen-dh
    - cwd: /etc/openvpn/easy-rsa

generate_key_for_openvpn_server:
  cmd.run:
    - name: ./easyrsa gen-req openvpn-server-box nopass
    - cwd: /etc/openvpn/easy-rsa

sign_key_for_openvpn_server_using_ca_cert:
  cmd.run:
    - name: ./easyrsa sign-req server openvpn-server-box
    - cwd: /etc/openvpn/easy-rsa

verify_openvpn_server_key:
  cmd.run:
    - name: openssl verify -CAfile pki/ca.crt pki/issued/openvpn-server-box.crt
    - cwd: /etc/openvpn/easy-rsa

$ sudo cp pki/dh.pem /etc/openvpn/server/
/etc/openvpn/server/dh.pem:
  file.managed:
    - source: /etc/openvpn/easy-rsa/pki/dh.pem
    - force: true

/etc/openvpn/server/ca.crt:
  file.managed:
    - source: /etc/openvpn/easy-rsa/pki/ca.crt
    - force: true

/etc/openvpn/server/openvpn-server-box.crt:
  file.managed:
    - source: /etc/openvpn/easy-rsa/pki/issued/openvpn-server-box.crt
    - force: true

/etc/openvpn/server/openvpn-server-box.key:
  file.managed:
    - source: /etc/openvpn/easy-rsa/pki/private/openvpn-server-box.key
    - force: true
