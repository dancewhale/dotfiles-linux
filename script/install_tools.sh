#!/bin/bash -e
sudo pacman --noconfirm -Sy cargo

which cargo || cargo install grex ripgrep sd

sudo pacman --noconfirm -S jq tokei  fd  bat exa zoxide ripgrep   ack  the_sliver_searcher

sudo pacman --noconfirm -S ack  cht.sh cht.sh calibre

sudo pacman --noconfirm -S visual-studio-code-bin
