#!/bin/bash -x

[ -f /etc/redsocks.conf ] && sudo rm /etc/redsocks.conf 
sudo ln -t /etc/         ${PWD}/etc/redsocks.conf
sudo systemctl enable redsocks && sudo systemctl restart redsocks

[ -f /etc/privoxy/config ] && sudo rm /etc/privoxy/config 
sudo ln -t /etc/privoxy/ ${PWD}/etc/privoxy/config
sudo systemctl enable privoxy  && sudo systemctl restart privoxy


