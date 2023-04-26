#!/usr/bin/env sh

# 安装bitwarden 在后面进行渲染使用
sudo yum install -y nodejs

# 安装bitwarden
npm config set registry http://mirrors.cloud.tencent.com/npm

bw --help || sudo npm install --unsafe-perm -g @bitwarden/cli

sudo chmod +x /usr/local/bin/bw

bw login
