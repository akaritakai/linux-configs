samba
====
samba providea a free server implementation of the SMB/CIFS networking protocol. As such, it provides file server services for Windows clients.

Installation
------------
```sh
apt-get update
apt-get -y install samba
```

You will also have to follow the instructions in MySQL.md to set up the MySQL portion.

Configs
-------
  - **smb.conf** holds the configuration script which should be placed in /etc/samba/
