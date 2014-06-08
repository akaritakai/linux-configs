noip
====
noip is the dynamic DNS update program provided by No-IP.com

Installation
------------
```sh
cd /usr/local/src
wget http://www.no-ip.com/client/linux/noip-duc-linux.tar.gz
tar xzf noip-duc-linux.tar.gz
mkdir noip2 && mv noip* noip2
cd noip2
make
make install
/usr/local/bin/noip2 -C (generates the config)
```

Configs
-------
  - **noip.conf** holds the upstart script
