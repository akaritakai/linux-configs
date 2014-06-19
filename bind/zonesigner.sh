#!/bin/bash

function update_serial() {
  local domain=$1
  local current_serial=`/usr/sbin/named-checkzone $1 /etc/bind/db.$1 | grep -Eho '[0-9]{10}'`
  local today=`date +%Y%m%d`
  if [[ $current_serial != $today* ]]; then
    sed -i 's/'$current_serial'/'$today'00/' /etc/bind/db.$1
  else
    sed -i 's/'$current_serial'/'$(($current_serial+1))'/' /etc/bind/db.$1
  fi
}

function sign_zone() {
  local domain=$1
  /usr/sbin/dnssec-signzone -A -3 $(head -c 1000 /dev/random | sha1sum | cut -b 1-16) -N INCREMENT -o $domain -t /etc/bind/db.$domain
}

function update() {
  local domain=$1
  update_serial $1
  sign_zone $1
}

readonly current_dir=`pwd`
cd /etc/bind

update my.first.domain
update my.second.domain
...

service bind9 restart
cd $current_dir
