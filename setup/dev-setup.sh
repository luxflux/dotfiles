#!/bin/bash

brew bundle

set -e

echo -n "DNSimple Email: "
read DNSIMPLE_EMAIL
echo -n "DNSimple Token (organization): "
read -s DNSIMPLE_TOKEN
echo 

mkdir -p /usr/local/var/log/caddy

sed "s/::DNSIMPLE_EMAIL::/${DNSIMPLE_EMAIL}/; s/::DNSIMPLE_TOKEN::/${DNSIMPLE_TOKEN}/" ./files/com.caddyserver.web.plist > ~/Library/LaunchAgents/com.caddyserver.web.plist
launchctl load -w ~/Library/LaunchAgents/com.caddyserver.web.plist

echo "Adding zsh to shells"
echo /usr/local/bin/zsh | sudo tee -a /etc/shells
echo "Changing shell for raf"
chsh -s /usr/local/bin/zsh raf
