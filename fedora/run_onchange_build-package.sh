#!/bin/bash -xe
#
# build from source
#
sudo dnf install -y @development-tools autoconf \
  gtk3-devel gnutls-devel \
  libtiff-devel giflib-devel libjpeg-devel libpng-devel libXpm-devel \
  ncurses-devel texinfo \
  libxml2-devel \
  jansson jansson-devel \
  libgccjit libgccjit-devel

git clone git://git.sv.gnu.org/emacs.git  ~/emacs || true

pushd ~/emacs

./autogen.sh



export CC=/usr/bin/gcc CXX=/usr/bin/gcc

./configure \
    --with-native-compilation \
    --with-json \
    --with-pgtk \
    --with-xml2 \
    --with-modules \
    --with-mailutils


make -j5

sudo make install
