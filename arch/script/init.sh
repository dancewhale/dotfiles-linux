#!/bin/bash

pacman -Syyu
pacman -S sudo vim xf86-video-vesa

useradd -m -G wheel -s /bin/bash whale
passwd whale

sudo pacman -S net-tools inetutils

sudo pacman -S adobe-source-han-serif-cn-fonts wqy-zenhei
sudo pacman -S noto-fonts noto-fonts-cjk noto-fonts-emoji noto-fonts-extra

# add archlinuxcn

paru -Sy waybar-hyprland

paru -Sy rofi-lbonn-wayland-only-git

paru -Sy clash-meta

# setting locale
