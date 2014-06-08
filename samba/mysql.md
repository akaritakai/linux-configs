Installation of MySQL Server
----------------------------
```sh
apt-get update
apt-get -y install mysql-server
```

Follow all of the prompts and ensure you remember your MySQL root password!

Creation of Databases, Users, and Tables
----------------------------------------

Create the samba database
```sh
mysqladmin -p create samba
```
Log in as the MySQL root user
```sh
mysql -u root -p
```
Create a user specific to samba
```sql
GRANT ALL ON samba.* TO 'samba'@'127.0.0.1' IDENTIFIED BY 'somepassword';
FLUSH PRIVILEGES;
```
Create tables
```sql
USE samba;
CREATE TABLE user (
    `logon_time` INT(9),
    `logoff_time` INT(9),
    `kickoff_time` INT(9),
    `pass_last_set_time` INT(9),
    `pass_can_change_time` INT(9),
    `pass_must_change_time` INT(9),
    `username` VARCHAR(255),
    `domain` VARCHAR(255),
    `nt_username` VARCHAR(255),
    `nt_fullname` VARCHAR(255),
    `home_dir` VARCHAR(255),
    `dir_drive` VARCHAR(4),
    `logon_script` VARCHAR(255),
    `profile_path` VARCHAR(255),
    `acct_desc` VARCHAR(255),
    `workstations` VARCHAR(255),
    `unknown_str` VARCHAR(255),
    `munged_dial` VARCHAR(255),
    `uid` INT(9) NOT NULL PRIMARY KEY AUTO_INCREMENT,
    `gid` INT(9),
    `user_sid` VARCHAR(255),
    `group_sid` VARCHAR(255),
    `lm_pw` VARCHAR(255),
    `nt_pw` VARCHAR(255),
    `acct_ctrl` INT(9),
    `unknown_3` INT(9),
    `logon_divs` INT(9),
    `hours_len` INT(9),
    `unknown_5` INT(9),
    `unknown_6` INT(9) DEFAULT "1260",
    `bad_password_count` INT(9),
    `logon_count` INT(9),
    `logon_hours` VARCHAR(255)
);
```
