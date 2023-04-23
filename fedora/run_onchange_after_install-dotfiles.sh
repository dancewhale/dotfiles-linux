#!/usr/bin/env sh

# 安装k8s 相关

groups | grep docker || sudo gpasswd -a $USER docker

newgrp docker

sudo dnf install -y kubernetes-client

# 启动网络服务
systemctl start clash@service
