#!/usr/bin/env sh

# 安装k8s 相关

sudo pacman -S docker kubectl

groups | grep docker || sudo gpasswd -a $USER docker
