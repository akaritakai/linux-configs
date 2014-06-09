#!/bin/bash

usage() {
  echo "This script updates various pieces of software."
  echo "  update znc"
  echo "    This command updates and restarts the ZNC IRC Bouncer"
  exit 1
}

znc() {
  if [ ! -d "/usr/local/src/znc" ]; then
    git clone --recursive https://github.com/akaritakai/znc /usr/local/src/znc
  else
    cd /usr/local/src/znc
    git reset --hard
    git pull
  fi
  
  # Build/Install ZNC
  cd /usr/local/src/znc
  ./autogen.sh
  ./configure --prefix="/usr/local" --enable-perl --enable-python --enable-cyrus --enable-tcl && make clean && make && make install

  # Get latest contrib modules
  if [ ! -d "/usr/local/src/znc-contrib" ]; then
    git clone --recursive https://github.com/kylef/znc-contrib /usr/local/src/znc-contrib
  else
    cd /usr/local/src/znc-contrib
    git reset --hard
    git pull
  fi
  
  # Build/Install contrib modules
  cd /usr/local/src/znc-contrib
  sed -i 's/MODDIR=.*/MODDIR=\/usr\/local\/lib\/znc/' Makefile
  make privmsg
}

# Test for root (script must run with it)
if [ "$(id -u)" != "0" ]; then
  echo "This script must run as root"
  exit 1
fi

# Check number of args
if (( $# != 1 ))
then
  usage
fi

# Get the PWD
readonly current_dir=$(pwd)

if [ $1 == "znc" ]; then
  znc
  initctl stop znc
  initctl start znc
else
  usage
fi

cd $current_dir
