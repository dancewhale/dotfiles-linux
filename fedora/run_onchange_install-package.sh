#!/bin/bash -xe

sudo yum install -y cargo gcc make

which cargo && cargo install grex

sudo yum install -y  jq tokei  bat exa zoxide ripgrep   ack  the_silver_searcher
sudo yum install -y  ack fd-find  calibre

sudo yum install -y  fzf  rofi  barrier docker

sudo yum install -y  gvim  emacs  net-tools

# 代码相关
sudo yum install -y nodejs golang

# install vscode


# install rime
dnf install -y fcitx5-rime  fcitx5-autostart  fcitx5-chinese-addons switch-desk
