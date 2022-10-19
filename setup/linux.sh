
sudo apt install nfs-kernel-server

# /etc/exports
# /home/raf/projects 192.168.64.0/24(rw,insecure,sync,no_subtree_check,all_squash,anonuid=1000,anongid=1000)
sudo exportfs -a
sudo systemctl enable rpc-statd
sudo systemctl enable nfs-kernel-server

sudo apt-add-repository ppa:fish-shell/release-3
sudo add-apt-repository ppa:neovim-ppa/stable
sudo apt install imagemagick neovim ripgrep hub fish fzf exa language-pack-en dnsutils iputils-ping

npm install -g diff-so-fancy


sudo cp /home/raf/projects/lf/dotfiles/setup/caddy/data/caddy/pki/authorities/local/root.crt /usr/local/share/ca-certificates/caddy.crt
sudo cp /home/raf/projects/lf/dotfiles/setup/caddy/data/caddy/pki/authorities/local/intermediate.crt /usr/local/share/ca-certificates/caddy-intermediate.crt
update-ca-certificates
sudo ln -s /etc/ssl/certs/ca-certificates.crt /usr/lib/ssl/cert.pem


sudo curl -s -o /usr/share/keyrings/syncthing-archive-keyring.gpg https://syncthing.net/release-key.gpg
echo "deb [signed-by=/usr/share/keyrings/syncthing-archive-keyring.gpg] https://apt.syncthing.net/ syncthing stable" | sudo tee /etc/apt/sources.list.d/syncthing.list
sudo apt update
sudo apt install syncthing
systemctl --user raf syncthing.service
systemctl --user status syncthing.service
