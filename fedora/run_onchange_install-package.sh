#!/bin/bash -xe

sudo yum install -y cargo gcc make

which cargo && cargo install grex

sudo yum install -y  jq tokei  bat exa zoxide ripgrep   ack  the_silver_searcher
sudo yum install -y  ack fd-find  calibre

sudo yum install -y  fzf  rofi  barrier docker

sudo yum install -y  vim-enhanced  net-tools

# 代码相关
sudo yum install -y nodejs golang

# install vscode


# install rime
sudo dnf install -y fcitx5-rime fcitx5-table-extra fcitx5-zhuyin \
               switchdesk fcitx5 fcitx5-autostart fcitx5-configtool \
	       fcitx5-chinese-addons fcitx5-gtk fcitx5-qt fcitx5-qt-module kcm-fcitx5

imsettings-switch fcitx5

sudo alternatives --config xinputrc

sudo grep "fcitx5" /etc/environment || \
       	echo 'INPUT_METHOD=fcitx5
GTK_IM_MODULE=fcitx5
QT_IM_MODULE=fcitx5
XMODIFIERS=@im=fcitx5'| sudo tee -a /etc/environment


git clone https://github.com/rime/plum.git ~/.plum

pushd  ~/.plum

rime_frontend=fcitx5-rime bash rime-install  iDvel/rime-ice:others/recipes/full

fcitx5-configtool
