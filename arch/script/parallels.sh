#!/usr/bin/env sh

pacman -S perl hplip libelf cups gcc make nbd \
	dkms multipath-tools hplip pam alsa-lib

paru -S checkpolicy

systemctl --user enable prlcp
systemctl --user start prlcp
