#!/bin/bash

install_paru () {
    mkdir -p ~/cache
    git clone https://aur.archlinux.org/paru.git  ~/cache/paru
    pushd ~/cache/paru
    makepkg -si
    popd
}

sudo pacman -Syu
sudo pacman -S --noconfirm --needed   sudo chezmoi vim xf86-video-vesa git  bitwarden-cli

sudo pacman -S --noconfirm --needed   net-tools inetutils  base-devel

# font setting
sudo pacman -S --noconfirm --needed   adobe-source-han-serif-cn-fonts wqy-zenhei
sudo pacman -S --noconfirm --needed   noto-fonts noto-fonts-cjk noto-fonts-emoji noto-fonts-extra

which paru || install_paru

paru -Sy  hyprland-git  waybar-hyprland-git  waynergy-git wlogout

paru -Sy rofi-lbonn-wayland-only-git



# app install
sudo pacman -S --noconfirm --needed   kitty wl-clipboard libxkbcommon
