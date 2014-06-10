#!/bin/bash

function get_mysql_pw() {
  local password
  read -p "Enter MySQL Password: " -s password; echo
  eval "$1=$password"
}

function add_domain() {
  # Add new domain
  local domain; read -p "Enter new domain: " domain; echo; readonly domain
  mysql -u root -p$mysql_pw -e "INSERT INTO mail.virtual_domains (name) VALUES ('$domain');"

  # Don't forget to add the inbox folder!
  mkdir -p /var/mail/vhosts/$domain
  chown -R vmail:vmail /var/mail/vhosts/$domain
}

function add_user() {
  # Show domain list
  local output=$(mysql -u root -p$mysql_pw -t <<< "SELECT id,name FROM mail.virtual_domains;")
  if [ ! -z "$output" ]; then echo "$output"; fi

  # Add new user
  local domain_id; read -p "Enter domain id: " domain_id; echo; readonly domain_id
  local email; read -p "Enter email: " email; echo; readonly email
  local password; read -p "Enter password: " password; echo; readonly password
  mysql -u root -p$mysql_pw -e "INSERT INTO mail.virtual_users (domain_id, email, password) VALUES ('$domain_id', '$email', ENCRYPT('$password', CONCAT('\$6$', SUBSTRING(SHA(RAND()), -16))));"
}

function add_alias() {
  # Show user list
  local output=$(mysql -u root -p$mysql_pw -t <<< "SELECT domain_id,email FROM mail.virtual_users;")
  if [ ! -z "$output" ]; then echo "$output"; fi

  # Add new alias
  local domain_id; read -p "Enter domain id: " domain_id; echo; readonly domain_id
  local source_email; read -p "Enter source email: " source_email; echo; readonly source_email
  local destn_email; read -p "Enter destination email: " destn_email; echo; readonly destn_email
  mysql -u root -p$mysql_pw -e "INSERT INTO mail.virtual_aliases (domain_id, source, destination) VALUES ('$domain_id', '$source_email', '$destn_email')";
}

function list_domains() {
  # Show domain lsit
  local output=$(mysql -u root -p$mysql_pw -t <<< "SELECT id,name FROM mail.virtual_domains;")
  if [ ! -z "$output" ]; then echo "$output"; fi
}

function list_users() {
  # Show user list
  local output=$(mysql -u root -p$mysql_pw -t <<< "SELECT id,email FROM mail.virtual_users;")
  if [ ! -z "$output" ]; then echo "$output"; fi
}

function list_aliases() {
  # Show alias list
  local output=$(mysql -u root -p$mysql_pw -t <<< "SELECT id,source,destination FROM mail.virtual_aliases;")
  if [ ! -z "$output" ]; then echo "$output"; fi
}

function delete_domain() {
  # Show domain list
  local output=$(mysql -u root -p$mysql_pw -t <<< "SELECT id,name FROM mail.virtual_domains;")
  if [ ! -z "$output" ]; then echo "$output"; fi; echo

  # Delete domain
  local domain_id; read -p "Enter domain id: " domain_id; echo; readonly domain_id
  mysql -u root -p$mysql_pw -e "DELETE FROM mail.virtual_domains WHERE id='$domain_id';"
}

function delete_user() {
  # Show user list
  local output=$(mysql -u root -p$mysql_pw -t <<< "SELECT id,email FROM mail.virtual_users;")
  if [ ! -z "$output" ]; then echo "$output"; fi; echo

  # Delete user
  local user_id; read -p "Enter user id: " user_id; echo; readonly user_id
  mysql -u root -p$mysql_pw -e "DELETE FROM mail.virtual_users WHERE id='$user_id';"
}

function delete_alias() {
  # Show alias list
  local output=$(mysql -u root -p$mysql_pw -t <<< " SELECT id,source,destination FROM mail.virtual_aliases;")
  if [ ! -z "$output" ]; then echo "$output"; fi; echo

  # Delete alias
  local alias_id; read -p "Enter alias id: " alias_id; echo; readonly alias_id
  mysql -u root -p$mysql_pw -e "DELETE FROM mail.virtual_aliases WHERE id='$alias_id';"
}

mysql_pw=""; get_mysql_pw mysql_pw; readonly mysql_pw; echo

# Menu Options

function print_menu_opts() {
  echo "1) Add Domain"
  echo "2) Add User"
  echo "3) Add Alias"
  echo "4) List Domains"
  echo "5) List Users"
  echo "6) List Aliases"
  echo "7) Delete Domain"
  echo "8) Delete Users"
  echo "9) Delete Alias"
  echo "0) Exit"
}

echo "MySQL Email Management"
print_menu_opts

while true; do
  read -p "Please select an option: " option
  case $option in
    [1]* ) add_domain;;
    [2]* ) add_user;;
    [3]* ) add_alias;;
    [4]* ) list_domains;;
    [5]* ) list_users;;
    [6]* ) list_aliases;;
    [7]* ) delete_domain;;
    [8]* ) delete_user;;
    [9]* ) delete_alias;;
    [0]* ) break;;
       * ) echo "Please select an option 0-9.";
           echo; print_menu_opts;;
  esac
done
