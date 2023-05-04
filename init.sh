#!/bin/bash

ARCH=$(uname -m)

if [ $ARCH = "aarch64" ]; then
	export ARCH=arm64
elif [ $ARCH = "x86_64" ]; then
	export ARCH=amd64
fi

sudo wget http://67.230.186.218/chezmoi_2.33.3_linux_${ARCH}/chezmoi -P /usr/local/bin/

sudo wget http://67.230.186.218/clash-linux-${ARCH}-2023.04.16 -O /usr/local/bin/clash

sudo chmod +x /usr/local/bin/*

chezmoi init

chezmoi apply

pushd ~/.local/share/chezmoi && git submodule update --init
