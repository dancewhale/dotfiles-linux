#!/usr/bin/env sh

# build librime and lua plugin
#
sudo yum install -y librime librime-devel librime-lua librime-tools \
        gcc-c++ boost boost-devel glog-devel gtest-devel \
        yaml-cpp-devel opencc-devel marisa-devel leveldb-devel luajit luajit-devel


# install rime
sudo dnf install -y fcitx5-rime fcitx5-table-extra fcitx5-zhuyin \
        switchdesk fcitx5 fcitx5-autostart fcitx5-configtool \
        fcitx5-chinese-addons fcitx5-gtk fcitx5-qt fcitx5-qt-module kcm-fcitx5 \
        xorg-x11-fonts-100dpi xorg-x11-fonts-75dpi xorg-x11-font-utils \
        librime-devel

# 系统安装 rime 输入方案
git clone https://github.com/rime/plum.git ~/.plum || true

pushd ~/.plum

mkdir -p ~/.local/share/rime/ice
mkdir -p ~/.local/share/rime/frost

rime_dir="$HOME/.local/share/rime/ice" bash rime-install iDvel/rime-ice

rime_dir="$HOME/.local/share/rime/frost" bash rime-install gaboolic/rime-frost:others/recipes/full


rm -rf ~/.local/share/fcitx5/rime
ls -s  ~/.local/share/rime/frost ~/.local/share/fcitx5/rime
