OpenSSH
=======
OpenSSH is an open source server implementation of the SSH protocol which providesencrypted communication sessions.

Installation
------------
```sh
apt-get update
apt-get -y install ssh
ssh-keygen -b 4096 -t rsa -f /etc/ssh/ssh_host_rsa_key
```

Configs
-------
  - **sshd_config** holds a openssh-server configuration, which should be placed in /etc/ssh/
