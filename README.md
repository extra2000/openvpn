# openvpn

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT) [![semantic-release](https://img.shields.io/badge/%20%20%F0%9F%93%A6%F0%9F%9A%80-semantic--release-e10079.svg)](https://github.com/semantic-release/semantic-release) [![Build Status](https://travis-ci.com/extra2000/openvpn.svg?branch=master)](https://travis-ci.com/extra2000/openvpn)

Automate OpenVPN server deployment


# Generate Saltstack Master and Minion Keys

```
$ cd provisions/salt/keys
```

Generate key for `openvpn-saltmaster`:
```
$ openssl genrsa -out openvpn-saltmaster.pem
$ openssl rsa -in openvpn-saltmaster.pem -pubout -out openvpn-saltmaster.pub
```

Generate key for `openvpn-server-box`:
```
$ openssl genrsa -out openvpn-server-box.pem
$ openssl rsa -in openvpn-server-box.pem -pubout -out openvpn-server-box.pub
```

Generate key for `openvpn-client-box`:
```
$ openssl genrsa -out openvpn-client-box.pem
$ openssl rsa -in openvpn-client-box.pem -pubout -out openvpn-client-box.pub
```
