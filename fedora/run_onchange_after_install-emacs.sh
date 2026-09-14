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
