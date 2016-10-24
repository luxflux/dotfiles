#!/bin/sh

set -e

mkdir -p /etc/resolver
sudo sh -c 'echo "nameserver 127.0.0.1" > /etc/resolver/dev'
cp ./files/dnsmasq.conf /usr/local/etc/dnsmasq.conf
sudo brew services start dnsmasq

sed -E -e 's/listen( +)8080;/listen\180;/' -i '' /usr/local/etc/nginx/nginx.conf
sudo brew services start nginx
