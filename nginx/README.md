nginx
=====
nginx is an open source reverse proxy, cache, and web server.

Installation
------------
```sh
add-apt-repository ppa:nginx/development
apt-get update
apt-get -y install nginx-full
```

Configs
-------
  - **nginx.conf** holds a general base configuration
  - **ssl.conf** holds a general SSL configuration which emphasizes maximum security

All other configurations are geared toward specific use cases.
