#!/usr/bin/env sh

# build librime and lua plugin
#
sudo yum install librime librime-devel gcc-c++ boost boost-devel glog-devel gtest-devel \
	yaml-cpp-devel opencc-devel marisa-devel leveldb-devel luajit luajit-devel

git clone https://github.com/rime/librime.git -b 1.8.5 --depth=1 /tmp/librime || true

pushd /tmp/librime

git clone https://github.com/hchunhui/librime-lua.git --depth 1 plugins/lua || true
make -j4
make -j4 merged-plugins
sudo make install

# install rime
sudo dnf install -y fcitx5-rime fcitx5-table-extra fcitx5-zhuyin \
	switchdesk fcitx5 fcitx5-autostart fcitx5-configtool \
	fcitx5-chinese-addons fcitx5-gtk fcitx5-qt fcitx5-qt-module kcm-fcitx5 \
	xorg-x11-fonts-100dpi xorg-x11-fonts-75dpi xorg-x11-font-utils \
	librime-devel

imsettings-switch fcitx5

sudo alternatives --config xinputrc

sudo grep "fcitx5" /etc/environment ||
	echo 'INPUT_METHOD=fcitx5
GTK_IM_MODULE=fcitx5
QT_IM_MODULE=fcitx5
XMODIFIERS=@im=fcitx5' | sudo tee -a /etc/environment

# 系统安装 rime 输入方案
git clone https://github.com/rime/plum.git ~/.plum || true

pushd ~/.plum

rime_frontend=fcitx5-rime bash rime-install iDvel/rime-ice:others/recipes/full

# 安装 rime-ice 方案到本地，提供给emacs-rime
git clone https://github.com/iDvel/rime-ice.git ~/.local/share/rime/ice
