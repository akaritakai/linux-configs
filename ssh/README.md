OpenSSH
=======
OpenSSH is an open source server implementation of the SSH protocol which providesencrypted communication sessions.

Installation
------------
```sh
apt-get update
apt-get -y install ssh
```

Additionally delete all the ssh keys in the /etc/ssh/ folder. When the OpenSSH server restarts, it should repopulate them.

Configs
-------
  - **sshd_config** holds a openssh-server configuration, which should be placed in /etc/ssh/
