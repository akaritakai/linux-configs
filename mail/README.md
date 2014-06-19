Mail Server
============

Here are instructions on how to set up a secure e-mail server with Postfix + Dovecot + MySQL

Follow the mysql.md instructions and then the instructions in the Dovecot folder and then the Postfix folder.

The below operations can be utilized after the above are set up.

Adding Domains
==============

Suppose you would like to add a domain `example.org` from which to send and receive mail fro
m.

1. Add the domain to the database: 

```sql
INSERT INTO mail.virtual_domains (name) VALUES ('example.org');
```

2. Add the inbox folder:

```sh
mkdir -p /var/mail/vhosts/example.org
chown -R vmail:vmail /var/mail/vhosts/example.org
```

Adding a New User
=================
Suppose you would like to add a new user to your domain. Let's call him `bob@example.org`. Let's get bob set up with password `asdf` as well!

1. Add the user to the database:

```sql
INSERT INTO mail.virtual_users (email, password)
  VALUES ('bob@example.org', 
    ENCRYPT('asdf',
      CONCAT('$6$', SUBSTRING(SHA(RAND()), -16))));
```

2. Allow the user to send e-mail from his own account:

```sql
INSERT INTO mail.virtual_allowed (user, email) VALUES ('bob@example.org', 'bob@example.org');
```

Adding an Alias
===============
Suppose you're `bob@example.org`. You maintain a support link for people to get support, and you want to forward all e-mail from `support@example.org` to your own address.

1. Add the alias:

```sql
INSERT INTO mail.virtual_aliases (source, destination) VALUES ('support@example.org', 'bob@example.org');
```

Further suppose that you want bob to be able to send mail from `support@example.org` as well. That's easily added with the next query:

```sql
INSERT INTO mail.virtual_allowed (user, email) VALUES ('bob@example.org', 'support@example.org');
```

No-Reply E-mail Addresses
=========================
Suppose example.org sometimes sends mail from `no-reply@example.org` to give customers information about alerts and such. You don't /really/ want to that address to ever accept mail. What can you do?

1. Add the e-mail address to the no-reply list:

```sql
INSERT INTO mail.no_reply (email) VALUES ('no-reply@example.org');
```

Undoing These Actions
=====================

Simply do the reverse of these actions to undo any of them, using the appropriate SQL DELETE statement.
