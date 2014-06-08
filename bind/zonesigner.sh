#!/bin/bash

function update_serial() {
  local serial=`/usr/sbin/named-checkzone some.domain /etc/bind/db.some.domain | grep -Eho '[0-9]{10}'`
  local today=`date +%Y%m%d`
  if [[ $serial != $today* ]]; then
    sed -i 's/'$serial'/'$serial00'/' /etc/bind/db.some.domain
  fi
}

update_serial
/usr/sbin/dnssec-signzone -A -3 $(head -c 1000 /dev/random | sha1sum | cut -b 1-16) -N INCREMENT -o some.domain -t /etc/bind/db.some.domain
service bind9 restart
