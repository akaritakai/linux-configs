Dovecot
=======
Dovecot is an open source IMAP and POP3 mail server.

Installation
------------
```sh
apt-get update
apt-get -y install dovecot-core dovecot-imapd dovecot-pop3d dovecot-lmtpd dovecot-mysql
```
After configuration of Dovecot
```sh
adduser --system --home /var/mail --shell /bin/false --no-create-home --group vmail
chown -R vmail:vmail /var/mail
chown -R vmail:dovecot /etc/dovecot
chmod -R o-rwx /etc/dovecot
```


Configs
-------
All configs should go relatively in the /etc/dovecot/ folder
