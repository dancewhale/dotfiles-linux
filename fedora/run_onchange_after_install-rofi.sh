#!/bin/bash

git clone https://github.com/waycrate/swhkd.git /tmp/swhkd || true

pushd /tmp/swhkd

make build

sudo make install

sudo mkdir -p /etc/swhkd || true
sudo ln -s ~/.config/swhkd/swhkdrc /etc/swhkd/ || true

systemctl --user daemon-reload
systemctl --user enable swhks
systemctl --user start swhks

