Postfix
=======
Postfix is a free and open-source mail transfer agent.

Installation
------------
```sh
apt-get update
apt-get -y install postfix postfix-mysql
openssl dhparam -out /etc/postfix/dh512.pem 512
openssl dhparam -out /etc/postfix/dh1024.pem 1024
```

Note that you will also have to complete the setup in mysql.md

Configs
-------
All configs should go in the /etc/postfix/ folder
