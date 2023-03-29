#!/bin/bash -xe

# build emacs from source
#
sudo dnf install -y @development-tools autoconf \
  gtk3-devel gnutls-devel cmake make gcc\
  libtiff-devel giflib-devel libjpeg-devel libpng-devel libXpm-devel \
  ncurses-devel texinfo \
  libxml2-devel \
  jansson jansson-devel \
  libgccjit libgccjit-devel

git clone git://git.sv.gnu.org/emacs.git  /tmp/emacs || true

pushd /tmp/emacs

./autogen.sh



export CC=/usr/bin/gcc CXX=/usr/bin/gcc

#    --with-pgtk  no wayland for clipboard share bug \
./configure \
    --with-native-compilation \
    --with-json \
    --with-xml2 \
    --with-modules \
    --with-mailutils


make -j5

sudo make install

popd

# build librime and lua plugin
#
sudo yum install librime librime-devel gcc-c++ boost boost-devel glog-devel gtest-devel \
		 yaml-cpp-devel  opencc-devel marisa-devel leveldb-devel luajit luajit-devel

git clone https://github.com/rime/librime.git -b 1.8.5  --depth=1 /tmp/librime
push /tmp/librime
git clone https://github.com/hchunhui/librime-lua.git  plugins/lua
make merged-plugins
make install

