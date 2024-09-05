#!bin/bash

apt -y update
apt-get -y install spawn-fcgi libfcgi-dev build-essential
rm -rf /var/lib/apt/lists/*

echo "BUILDING"
gcc -o server server.c -lfcgi
echo "BUILD DONE"