BIND
====
BIND is an open source DNS server.

Installation
------------
```sh
apt-get update
apt-get -y install bind9 bind9utils
```

DNSSEC Configuration
--------------------
Create a Zone Signing Key
```sh
dnssec-keygen -a NSEC3RSASHA1 -b 2048 -n ZONE some.domain
```
Create a Key Signing Key
```sh
dnssec-keygen -f KSK -a NSEC3RSASHA1 -b 4096 -n ZONE some.domain
```
Add public keys with DNSKEY record to the data file
```sh
for key in `ls Ksome.domain*.key`; do
  echo "\$INCLUDE $key" >> db.some.domain
done
```
Sign the zone
```sh
dnssec-signzone -A -3 $(head -c 1000 /dev/random | sha1sum | cut -b 1-16) -N INCREMENT -o some.domain -t db.some.domain
```
To sign the zone in the future, use the zonesigner utility. Write it to /usr/sbin/zonesigner.
To make changes to the zone, edit db.some.domain, and then run
```sh
zonesigner some.domain db.some.domain
```
Finally, add a cron job that executes the key signing daily. After all, you don't want to fall prey to a [zone walking](http://en.wikipedia.org/wiki/Domain_Name_System_Security_Extensions#Zone_enumeration_issue.2C_controversy.2C_and_NSEC3) issue!


Configs
-------
  - **local.conf** holds domains we are authoritative for
  - **options.conf** holds general BIND9 options
  - **db.some.domain** holds a generic template for a data file for "some.domain"
