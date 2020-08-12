# openvpn

| License | Versioning | Build |
| ------- | ---------- | ----- |
| [![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT) | [![semantic-release](https://img.shields.io/badge/%20%20%F0%9F%93%A6%F0%9F%9A%80-semantic--release-e10079.svg)](https://github.com/semantic-release/semantic-release) | [![Build Status](https://travis-ci.com/extra2000/openvpn.svg?branch=master)](https://travis-ci.com/extra2000/openvpn) [![Build status](https://ci.appveyor.com/api/projects/status/xwl74yxorjweclgo/branch/master?svg=true)](https://ci.appveyor.com/project/nikAizuddin/openvpn/branch/master) |

Automate OpenVPN server deployment


## Getting Started

Make sure your current working directory is at the root of this project. Then, execute `vagrant up` with provider such as `virtualbox`, `libvirt`, or `hyperv`:
```
$ vagrant up --provider=virtualbox
$ vagrant ssh openvpn-saltmaster -- sudo salt -L 'openvpn-server-box,openvpn-client-box' state.highstate saltenv=base
```

Initialize Easy-RSA on OpenVPN server:
```
$ vagrant ssh openvpn-saltmaster -- sudo salt 'openvpn-server-box' state.sls openvpn.easyrsa
```

Configure OpenVPN server and enable service:
```
$ vagrant ssh openvpn-saltmaster -- sudo salt 'openvpn-server-box' state.sls openvpn.configure-server
$ vagrant ssh openvpn-saltmaster -- sudo salt 'openvpn-server-box' service.start openvpn@server
$ vagrant ssh openvpn-saltmaster -- sudo salt 'openvpn-server-box' service.enable openvpn@server
```

To create OpenVPN keys for client:
```
$ vagrant ssh openvpn-saltmaster -- sudo salt 'openvpn-server-box' state.sls openvpn.clientkey pillar=\'{"hostname": "openvpn-client-box"}\'
$ vagrant ssh openvpn-saltmaster -- sudo salt-cp --chunked 'openvpn-client-box' /var/cache/salt/master/minions/openvpn-server-box/files/etc/openvpn/client/ etc/openvpn/
```

Configure OpenVPN client and enable service:
```
$ vagrant ssh openvpn-saltmaster -- sudo salt 'openvpn-client-box' state.sls openvpn.configure-client pillar=\'{"hostname": "openvpn-client-box"}\'
$ vagrant ssh openvpn-saltmaster -- sudo salt 'openvpn-client-box' service.start openvpn@client
$ vagrant ssh openvpn-saltmaster -- sudo salt 'openvpn-client-box' service.enable openvpn@client
```


## Generate Saltstack Master and Minion Keys

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
