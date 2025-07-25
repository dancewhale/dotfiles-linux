#!/usr/bin/env sh

# 安装k8s 相关

sudo dnf install -y docker || newgrp docker

sudo systemctl enable docker

sudo systemctl start docker

sudo dnf install -y kubernetes-client

groups | grep docker || sudo gpasswd -a $USER docker

