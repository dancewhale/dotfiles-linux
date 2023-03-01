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



pacmanset
bashSetting
