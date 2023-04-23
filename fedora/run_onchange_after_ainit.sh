#!/usr/bin/env sh
# 创建专用账号 配置clash
sudo useradd -M -s /usr/sbin/nologin clash

sudo cp ~/.config/clash/clash.service /usr/lib/systemd/system/

# 首先初始化clash
sudo cp -r ~/.config/clash/* /etc/clash
chown -R clash:clash /etc/clash

sudo systemctl daemon-reload

sudo systemctl enable clash.service

sudo systemctl start clash.service
