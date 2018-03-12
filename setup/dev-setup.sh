#!/bin/sh

brew tap Homebrew/bundle
brew tap caskroom/cask

brew install mas

brew bundle

set -e

sudo mkdir -p /etc/resolver
sudo sh -c 'echo "nameserver 127.0.0.1" > /etc/resolver/test'
sudo cp ./files/dnsmasq.conf /usr/local/etc/dnsmasq.conf
sudo brew services start dnsmasq

sudo sed -E -e 's/listen( +)8080;/listen\180;/' -i '' /usr/local/etc/nginx/nginx.conf
sudo brew services start nginx

echo /usr/local/bin/zsh | sudo tee -a /etc/shells
chsh -s /usr/local/bin/zsh raf
