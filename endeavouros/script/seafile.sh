#!/bin/bash

printf '%b%s%b\n' "${FX_BOLD}${FG_GREEN}" "Post-Installation:"
printf '%b%s%b\n' "${FX_BOLD}${FG_GREEN}" "Start setting seafile."
# Setting seafile
# 安装并启动seafile
mkdir ~/Dropbox

session=$(bw unlock | grep export)
eval ${session:2}

surl=$(echo '{{ (bitwardenFields "item" "b27f7204-9341-4396-804e-aff9002a478a").url.value }}' | chezmoi execute-template)
suser=$(echo '{{ (bitwardenFields "item" "b27f7204-9341-4396-804e-aff9002a478a").user.value }}' | chezmoi execute-template)
spass=$(echo '{{ (bitwardenFields "item" "b27f7204-9341-4396-804e-aff9002a478a").password.value }}' | chezmoi execute-template)

seaf-cli status | grep Dropbox || seaf-cli sync -l "838a54d5-3992-4a1e-9948-67d5c4d1a903" -s $surl -d ~/Dropbox -u $suser -p $spass


