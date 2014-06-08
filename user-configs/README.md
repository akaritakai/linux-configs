User Configs
============

In here are some specific user and server configurations that I've found useful.

Useful Programs
---------------
This list specifically includes programs not installed by default on Ubuntu 14.04 server.
 - [ag](https://github.com/ggreer/the_silver_searcher) is faster than grep and just as nice.
 ```apt-get -y install silversearcher-ag```
 - [htop](http://hisham.hm/htop/) is a version of *top* on crack.
 ```apt-get -y install htop```
 - [iftop](http://www.ex-parrot.com/pdw/iftop/) is a monitoring utility that shows traffic bandwidth to and from IPs in realtime. ```apt-get -y install iftop```
 - [vnstat](http://humdi.net/vnstat/) is another traffic monitor, but this one gives averages for traffic use in a month! ```apt-get -y install vnstat```
 - [nmap](http://nmap.org/) is a security scanner, but there's no faster way to test if a service is listening properly than with this tool. ```apt-get -y install nmap```
 - [ffmpeg](http://www.ffmpeg.org/) is the tried and true audio converter. Nothing else works quite as well, or has quite as much support. You're better off compiling it from scratch though for some of the newer codecs like HEVC.
 - [weechat](http://www.weechat.org/) is hands down the best IRC client in existence. Accept no substitutes.
 ```sh
  add-apt-repository ppa:nesthib/weechat
  apt-get update
  apt-get -y install weechat
 ```
 - [ZNC](http://wiki.znc.in/ZNC) is weechat is the best IRC client, then ZNC is surely the best bouncer. Best compiled from the latest source.
 - [Keychain](http://www.funtoo.org/Keychain) is a gpg-agent/ssh-agent utility that allows concurrent logins to share the same agent instance! ```apt-get -y install keychain```
