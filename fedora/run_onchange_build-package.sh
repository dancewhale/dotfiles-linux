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

# build liberime
#
sudo yum install librime librime-devel

git clone https://github/com/merrickluo/liberime  --depth=1 /tmp/liberime
push /tmp/liberime
make all

sudo cp /tmp/liberime/src/*.so /usr/local/share/emacs/site-lisp/
