#!/usr/bin/env sh

# 登录bw, 注册session

bw login || true

BW_SESSION=$(bw unlock --raw)

echo "export  BW_SESSION=$BW_SESSION" >~/.bw.env

source ~/.bw.env
