#!/bin/bash

function get_mysql_pw() {
  local password
  read -p "Enter MySQL Password: " -s password; echo
  eval "$1=$password"
}

function add_domain() {
  # Get MySQL password
  local mysql_pw; get_mysql_pw mysql_pw; readonly mysql_pw; echo

  # Add new domain
  local domain; read -p "Enter new domain: " domain; echo; readonly domain
  mysql -u root -p$mysql_pw -e "INSERT INTO mail.virtual_domains (name) VALUES ('$domain');"
}

function add_user() {
  # Get MySQL password
  local mysql_pw; get_mysql_pw mysql_pw; readonly mysql_pw; echo

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
  # Get MySQL password
  local mysql_pw; get_mysql_pw mysql_pw; readonly mysql_pw; echo

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
  # Get MySQL password
  local mysql_pw; get_mysql_pw mysql_pw; readonly mysql_pw; echo

  # Show domain lsit
  local output=$(mysql -u root -p$mysql_pw -t <<< "SELECT id,name FROM mail.virtual_domains;")
  if [ ! -z "$output" ]; then echo "$output"; fi
}

function list_users() {
  # Get MySQL password
  local mysql_pw; get_mysql_pw mysql_pw; readonly mysql_pw; echo

  # Show user list
  local output=$(mysql -u root -p$mysql_pw -t <<< "SELECT id,email FROM mail.virtual_users;")
  if [ ! -z "$output" ]; then echo "$output"; fi
}

function list_aliases() {
  # Get MySQL password
  local mysql_pw; get_mysql_pw mysql_pw; readonly mysql_pw; echo

  # Show alias list
  local output=$(mysql -u root -p$mysql_pw -t <<< "SELECT id,source,destination FROM mail.virtual_aliases;")
  if [ ! -z "$output" ]; then echo "$output"; fi
}

function delete_domain() {
  # Get MySQL password
  local mysql_pw; get_mysql_pw mysql_pw; readonly mysql_pw; echo

  # Show domain list
  local output=$(mysql -u root -p$mysql_pw -t <<< "SELECT id,name FROM mail.virtual_domains;")
  if [ ! -z "$output" ]; then echo "$output"; fi; echo

  # Delete domain
  local domain_id; read -p "Enter domain id: " domain_id; echo; readonly domain_id
  mysql -u root -p$mysql_pw -e "DELETE FROM mail.virtual_domains WHERE id='$domain_id';"
}

function delete_user() {
  # Get MySQL password
  local mysql_pw; get_mysql_pw mysql_pw; readonly mysql_pw; echo

  # Show user list
  local output=$(mysql -u root -p$mysql_pw -t <<< "SELECT id,email FROM mail.virtual_users;")
  if [ ! -z "$output" ]; then echo "$output"; fi; echo

  # Delete user
  local user_id; read -p "Enter user id: " user_id; echo; readonly user_id
  mysql -u root -p$mysql_pw -e "DELETE FROM mail.virtual_users WHERE id='$user_id';"
}

function delete_alias() {
  # Get MySQL password
  local mysql_pw; get_mysql_pw mysql_pw; readonly mysql_pw; echo

  # Show alias list
  local output=$(mysql -u root -p$mysql_pw -t <<< " SELECT id,source,destination FROM mail.virtual_aliases;")
  if [ ! -z "$output" ]; then echo "$output"; fi; echo

  # Delete alias
  local alias_id; read -p "Enter alias id: " alias_id; echo; readonly alias_id
  mysql -u root -p$mysql_pw -e "DELETE FROM mail.virtual_aliases WHERE id='$alias_id';"
}

# Menu Options
echo "E-Mail User Management"
echo "1) Add Domain"
echo "2) Add User"
echo "3) Add Alias"
echo "4) List Domains"
echo "5) List Users"
echo "6) List Aliases"
echo "7) Delete Domain"
echo "8) Delete Users"
echo "9) Delete Alias"

while true; do
  read -p "Please select an option: " option
  case $option in
    [1]* ) add_domain;    break;;
    [2]* ) add_user;      break;;
    [3]* ) add_alias;     break;;
    [4]* ) list_domains;  break;;
    [5]* ) list_users;    break;;
    [6]* ) list_aliases;  break;;
    [7]* ) delete_domain; break;;
    [8]* ) delete_user;   break;;
    [9]* ) delete_alias;  break;;
       * ) echo "Please select an option 1-9.";;
  esac
done
