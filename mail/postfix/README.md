Postfix
=======
Postfix is a free and open-source mail transfer agent.

Installation
------------
```sh
apt-get update
apt-get -y install postfix postfix-mysql
mkdir -p /etc/postfix/crypto
openssl dhparam -out /etc/postfix/crypto/dh512.pem 512
openssl dhparam -out /etc/postfix/crypto/dh1024.pem 1024
```

Configs
-------
All configs should go relative to the /etc/postfix/ folder
