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
sudo dnf install -y fcitx5-rime fcitx5-table-extra fcitx5-zhuyin \
               fcitx5-autostart  fcitx5-chinese-addons switch-desk

sudo alternatives --config xinputrc


git clone https://github.com/rime/plum.git ~/.plum

pushd  ~/.plum

rime_frontend=fcitx5-rime bash rime-install  iDvel/rime-ice:others/recipes/full
