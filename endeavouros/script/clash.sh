#!/bin/bash


sudo pacman -S --noconfirm --needed bitwarden-cli

bw login 542727233@qq.com

bw sync

session=$(bw unlock |grep export)

echo "${session: 1}" >  ~/.config/zsh/passwd
