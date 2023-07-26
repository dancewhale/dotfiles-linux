#!/bin/bash

# 安装并启动seafile
sudo pacman -S  seafile-client

systemctl --user daemon-reload
systemctl --user enable seafile
systemctl --user start seafile

mkdir ~/Dropbox

sudo pacman  -S bitwarden-cli

seaf-cli status | grep Dropbox || seaf-cli sync -l "3440279a-fd36-4e94-bc0e-d3da402a1e58" -s "{{ (bitwardenFields "item" "b27f7204-9341-4396-804e-aff9002a478a").url.value }}" -d ~/Dropbox -u "{{ (bitwardenFields "item" "b27f7204-9341-4396-804e-aff9002a478a").user.value }}" -p "{{ (bitwardenFields "item" "b27f7204-9341-4396-804e-aff9002a478a").password.value }}"
