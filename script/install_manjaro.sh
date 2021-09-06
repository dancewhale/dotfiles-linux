#!/bin/bash -x

pacmanset(){
  sudo pacman-mirrors -i -c China -m rank
  sudo pacman --noconfirm -Syyu

  sudo chmod o+w /etc/pacman.conf
  arch='$arch'
  sudo grep -nr "archlinuxcn" /etc/pacman.conf || sudo cat >> /etc/pacman.conf <<EFO
[archlinuxcn]
Server = https://mirrors.tuna.tsinghua.edu.cn/archlinuxcn/$arch
EFO
  sudo chmod o-w /etc/pacman.conf
}


basePackage() {
  sudo pacman --noconfirm -Sy archlinuxcn-keyring yay

  sudo pacman --noconfirm -Sy chezmoi  fzf  rofi  barrier docker

  sudo pacman --noconfirm -Sy gvim  emacs=27.1-3

  sudo pacman --noconfirm -Sy binutils  base-devel
}


bashSetting() {
  # configure for FZF.
  grep  "bash_my" ~/.bash_profile || sudo cat >> ~/.bash_profile <<EFO
[ -f ~/.bash_my ] && . ~/.bash_my
EFO

  grep  "bash_my" ~/.bashrc || sudo cat >> ~/.bashrc <<EFO
[ -f ~/.bash_my ] && . ~/.bash_my
EFO
  # configure for complete
  sudo pacman --noconfirm -S  bash-completion
}


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


syncSetting() {
  sudo pacman --noconfirm -S synology-drive-client
}

pacmanset
basePackage
bashSetting
chineseSetting
syncSetting
