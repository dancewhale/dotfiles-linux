#!/usr/bin/env sh

# 修复vmware 剪切板问题
sudo cp ~/.local/bin/*  /usr/local/bin/

sudo sed -i 's#/usr/bin/vmware-user-suid-wrapper#/usr/local/bin/vmware-user-autostart-wrapper#g' \
                /etc/xdg/autostart/vmware-user.desktop

systemctl daemon-reload

# 安装k8s 相关

groups |grep docker || sudo gpasswd -a $USER docker

newgrp docker

sudo dnf install  -y kubernetes-client



# 安装lsp 相关 golang
