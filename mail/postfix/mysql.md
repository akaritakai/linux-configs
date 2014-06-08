Installation of MySQL Server
----------------------------
```sh
apt-get update
apt-get -y install mysql-server
```

Follow all of the prompts and ensure you remember your MySQL root password!

Creation of Databases and Tables
----------------------------------------

Create the mail database
```sh
mysqladmin -p create mail
```
Log in as the MySQL root user
```sh
mysql -u root -p
```
Create a user specific to mail
```sql
GRANT ALL ON mail.* TO 'mail'@'127.0.0.1' IDENTIFIED BY 'mailpassword';
FLUSH PRIVILEGES;
```
Create tables
```sql
USE mail;

CREATE TABLE `virtual_domains` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `virtual_users` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `domain_id` INT NOT NULL,
  `password` VARCHAR(106) NOT NULL,
  `email` VARCHAR(120) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`),
  FOREIGN KEY (domain_id) REFERENCES virtual_domains(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `virtual_aliases` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `domain_id` INT NOT NULL,
  `source` VARCHAR(100) NOT NULL,
  `destination` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`id`)
  FOREIGN KEY (domain_id) REFERENCES virtual_domains(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
```

Create Users
------------

Use the mysql.sh script
