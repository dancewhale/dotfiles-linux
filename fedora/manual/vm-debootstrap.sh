#!/usr/bin/env sh

# 只有在vmware 虚拟机中才手工执行
sudo grep "fuse" /etc/fstab || echo ".host:/  /mnt/  fuse.vmhgfs-fuse  defaults,allow_other  0  0" | sudo tee -a /etc/fstab

# 修复vmware 剪切板问题
sudo cp ~/.local/bin/* /usr/local/bin/

sudo sed -i 's#/usr/bin/vmware-user-suid-wrapper#/usr/local/bin/vmware-user-autostart-wrapper#g' \
	/etc/xdg/autostart/vmware-user.desktop

systemctl daemon-reload
