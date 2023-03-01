#!/bin/bash -e
sudo pacman --noconfirm -Sy cargo gcc make

which cargo && cargo install grex

sudo pacman --noconfirm -S jq tokei  fd  bat exa zoxide ripgrep   ack  the_silver_searcher

sudo pacman --noconfirm -S ack  calibre

sudo pacman --noconfirm -S code

sudo pacman --noconfirm -Sy archlinuxcn-keyring yay

sudo pacman --noconfirm -Sy chezmoi  fzf  rofi  barrier docker

sudo pacman --noconfirm -Sy gvim  emacs  net-tools

sudo pacman --noconfirm -Sy binutils  base-devel

sudo pacman --noconfirm -S synology-drive-client

chineseSetting() {
  sudo pacman -R $(pacman -Qsq fcitx)
  sudo pacman --noconfirm -S fcitx5-chinese-addons fcitx5 fcitx5-gtk  fcitx5-qt fcitx5-rime \
	    fcitx5-configtool

  # 其它文泉驿字体
  sudo pacman --noconfirm -S wqy-microhei-lite  wqy-bitmapfont  wqy-zenhei
  # 选用字体
  sudo pacman --noconfirm -S adobe-source-han-sans-cn-fonts  adobe-source-han-serif-cn-fonts  noto-fonts-cjk
  yay -S --noconfirm wqy-microhei rime-cloverpinyin && fc-cache -fv
 
  homeDir="Public  Templates Videos Pictures Documents Download Music Desktop"
  for dir in $homeDir
  do
    if [ ! -d ~/$dir ]
    then
      mkdir ~/$dir
    fi
  done
}

chineseSetting
