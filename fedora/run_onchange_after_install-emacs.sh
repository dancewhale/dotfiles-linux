#!/bin/bash -xe

# build emacs from source
#
sudo dnf install -y @development-tools autoconf \
  gtk3-devel gnutls-devel cmake make gcc libtiff-devel giflib-devel libjpeg-devel libpng-devel libXpm-devel \
  ncurses-devel texinfo \
  libxml2-devel librsvg2-devel \
  jansson jansson-devel \
  libgccjit libgccjit-devel \
  ImageMagick  ImageMagick-devel \
  webkit2gtk4.0 webkit2gtk4.0-devel

sudo dnf install -y libtool

mkdir -p ~/cache

git clone https://github.com/emacs-mirror/emacs.git ~/cache/emacs -b emacs-29 --depth 1 || true

pushd ~/cache/emacs

./autogen.sh

export CC=/usr/bin/gcc CXX=/usr/bin/gcc

#    --with-pgtk  no wayland for clipboard share bug \
./configure \
  --with-native-compilation   --with-json \
  --with-cairo                --with-harfbuzz \
  --with-modules              --with-mailutils \
  --with-imagemagick          --with-png \
  --with-tiff                 --with-jpeg \
  --with-xpm                  --with-zlib \
  --with-rsvg                 --with-included-regex \
  --with-threads              --with-x-toolkit=gtk3 \
  --with-xwidgets             --with-gif \
  --with-xml2                 --with-pop \
  --without-compress-install  --with-native-compilation \
  --with-pgtk

make -j5

sudo make install

popd

# https://gist.github.com/algal/9fc1d9a1b3f35f84e94937eef90887c7
pushd $(mktemp -d)
cat <<EOF >terminfo-24bit.src
xterm-species|xterm with 24-bit color for Emacs (ISO8613-6 format),
  use=xterm-256color,
  setb24=\E[48\:2\:\:%p1%{65536}%/%d\:%p1%{256}%/%{255}%&%d\:%p1%{255}%&%dm,
  setf24=\E[38\:2\:\:%p1%{65536}%/%d\:%p1%{256}%/%{255}%&%d\:%p1%{255}%&%dm,
xterm-24bit|xterm with 24-bit color for Emacs (legacy format),
  use=xterm-256color,
  sitm=\E[3m,
  ritm=\E[23m,
  setb24=\E[48;2;%p1%{65536}%/%d;%p1%{256}%/%{255}%&%d;%p1%{255}%&%dm,
  setf24=\E[38;2;%p1%{65536}%/%d;%p1%{256}%/%{255}%&%d;%p1%{255}%&%dm,
EOF

tic -x -o ~/.terminfo terminfo-24bit.src
rm terminfo-24bit.src
