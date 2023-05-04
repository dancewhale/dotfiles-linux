#!/usr/bin/env sh
set -x
# 创建专用账号 配置clash
sudo useradd -M -s /usr/sbin/nologin clash

# 首先初始化clash 
sudo cp ~/.config/clash/clash.service /usr/lib/systemd/system/clash.service

sudo mkdir /etc/clash
sudo cp -r ~/.config/clash/* /etc/clash
sudo chown -R clash:clash /etc/clash

sudo systemctl daemon-reload

sudo systemctl enable clash.service

sudo systemctl start clash.service

