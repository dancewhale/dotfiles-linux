#!/bin/bash

pushd ~
sudo sh -c "$(curl -fsLS get.chezmoi.io)" -- -b /usr/local/bin
popd

sudo grep "fuse" /etc/fstab || echo ".host:/  /mnt/  fuse.vmhgfs-fuse  defaults,allow_other  0  0" | sudo tee -a /etc/fstab

pushd ~/.local/share/chezmoi && git submodule update --init

chezmoi init

chezmoi apply
