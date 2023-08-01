#!/bin/bash -x

# 安装并启动seafile
paru -S  seafile-client

systemctl --user daemon-reload
systemctl --user enable seafile
systemctl --user start seafile

mkdir ~/Dropbox

session=$(bw unlock |grep export)
eval ${session:2}

url=$(echo '{{ (bitwardenFields "item" "b27f7204-9341-4396-804e-aff9002a478a").url.value }}' | chezmoi execute-template)
user=$(echo '{{ (bitwardenFields "item" "b27f7204-9341-4396-804e-aff9002a478a").user.value }}' | chezmoi execute-template)
pass=$(echo '{{ (bitwardenFields "item" "b27f7204-9341-4396-804e-aff9002a478a").password.value }}' | chezmoi execute-template)

seaf-cli status | grep Dropbox || seaf-cli sync -l "3440279a-fd36-4e94-bc0e-d3da402a1e58" -s $url -d ~/Dropbox -u $user -p $pass
