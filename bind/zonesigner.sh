#!/bin/bash

function update_serial() {
  local current_serial=`/usr/sbin/named-checkzone some.domain /etc/bind/db.some.domain | grep -Eho '[0-9]{10}'`
  local today=`date +%Y%m%d`
  if [[ $current_serial != $today* ]]; then
    sed -i 's/'$current_serial'/'$today'00/' /etc/bind/db.some.domain
  else
    sed -i 's/'$current_serial'/'$(($current_serial+1))'/' /etc/bind/db.some.domain
  fi
}

readonly current_dir=`pwd`
cd /etc/bind
/usr/sbin/dnssec-signzone -A -3 $(head -c 1000 /dev/random | sha1sum | cut -b 1-16) -N INCREMENT -o some.domain -t /etc/bind/db.some.domain
service bind9 restart
cd $current_dir
