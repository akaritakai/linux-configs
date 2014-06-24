samba
====
samba providea a free server implementation of the SMB/CIFS networking protocol. As such, it provides file server services for Windows clients.

**IMPORTANT NOTE:** I'm not sure on the exact set of instructions to get the MySQL backend to be recognized by default in Ubuntu. If anyone does know, let me know.

Installation
------------
```sh
apt-get update
apt-get -y install samba
```

You will also have to follow the instructions in mysql.md to set up the MySQL portion.

Usage
-----

Adding a user (you will be prompted for the password)
```sh
pdbedit -a -u user
```
Changing a user's password
```sh
smbpasswd user
```
Deleting a user
```sh
pdbedit -x user
```
Reloading the configuration file
```sh
service smbd restart
service nmbd restart
```

Configs
-------
  - **smb.conf** holds the configuration script which should be placed in /etc/samba/
  - **mysql.md** holds the instructions for setting up the MySQL password backend
