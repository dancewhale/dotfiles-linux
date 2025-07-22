#!/bin/bash
# 其它文泉驿字体
sudo pacman --noconfirm -S --needed wqy-microhei-lite wqy-bitmapfont ttf-sarasa-gothic \
  wqy-zenhei ttf-roboto-mono-nerd noto-fonts noto-fonts-cjk noto-fonts-emoji
# 选用字体
sudo pacman --noconfirm -S --needed adobe-source-han-sans-cn-fonts \
  adobe-source-han-serif-cn-fonts fontconfig


sudo pacman -Sy ttf-iosevka-nerd ttf-firacode-nerd  ttf-mononoki-nerd \
         ttf-jetbrains-mono  ttf-jetbrains-mono-nerd  ttf-fantasque-sans-mono

yay -Sy ttf-lxgw-bright-code-git  ttf-lxgw-wenkai-screen ttf-harmonyos-sans nerd-fonts-sarasa-term
