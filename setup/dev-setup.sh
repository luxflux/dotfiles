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

echo "Redirect http and https to caddy"
sudo cp ./files/pf-anchors-caddy /etc/pf.anchors/caddy
sudo cp ./files/pf-caddy /etc/pf-caddy.conf
sudo cp ./files/com.apple.pfctl-caddy.plist /Library/LaunchDaemons/com.apple.pfctl-caddy.plist
sudo launchctl load -w /Library/LaunchDaemons/com.apple.pfctl-caddy.plist

echo "Adding zsh to shells"
echo /usr/local/bin/zsh | sudo tee -a /etc/shells
echo "Changing shell for raf"
chsh -s /usr/local/bin/zsh raf
