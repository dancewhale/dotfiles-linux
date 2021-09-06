#!/bin/bash -x

sudo grep "pritunl" /etc/pacman.conf || sudo tee -a /etc/pacman.conf << EOF
[pritunl]
Server = https://repo.pritunl.com/stable/pacman
EOF

sudo pacman-key --keyserver hkp://keyserver.ubuntu.com -r 7568D9BB55FF9E5287D586017AE645C0CF8E292A
sudo pacman-key --lsign-key 7568D9BB55FF9E5287D586017AE645C0CF8E292A
sudo pacman -Sy

sudo pacman --noconfirm -S pritunl-client-electron

sudo pacman --noconfirm -S pritunl-client-electron-numix-theme

sudo pacman --noconfirm -S net-tools  trojan privoxy google-chrome

sudo cp ~/.local/bin/trojan /usr/bin

which redsocks || yay -Sy redsocks-git
