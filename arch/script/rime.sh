#!/usr/bin/env sh

# build librime and lua plugin
#
sudo pacman -S librime fcitx5-im fcitx5-pinyin-zhwiki fcitx5-gtk fcitx5-qt

imsettings-switch fcitx5

sudo alternatives --config xinputrc

sudo grep "fcitx5" /etc/environment ||
	echo 'INPUT_METHOD=fcitx5
GTK_IM_MODULE=fcitx5
QT_IM_MODULE=fcitx5
XMODIFIERS=@im=fcitx5' | sudo tee -a /etc/environment

# 系统安装 rime 输入方案
paru -Sy rime-ice-git

ceshi
