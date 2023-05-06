#!/bin/bash -xe

sudo yum install -y cargo gcc make

which cargo && cargo install grex tree-sitter-cli

sudo dnf install -y snapd
sudo ln -s /var/lib/snapd/snap /snap

sudo yum install -y jq tokei bat exa zoxide ripgrep ack the_silver_searcher
sudo yum install -y ack fd-find calibre

sudo yum install -y fzf rofi barrier docker

sudo yum install -y vim-enhanced net-tools

# 代码相关
# shell
sudo yum install -y shfmt shellcheck
# lisp
sudo yum install -y sbcl
# golang
sudo yum install -y golang

go install github.com/acroca/go-symbols@latest
go install github.com/cweill/gotests/gotests@latest
go install github.com/fatih/gomodifytags@main
go install github.com/josharian/impl@latest
go install github.com/ramya-rao-a/go-outline@latest
go install github.com/rogpeppe/godef@latest
go install github.com/sqs/goreturns@latest
go install github.com/x-motemen/gore/cmd/gore@latest
go install golang.org/x/lint/golint@latest
go install golang.org/x/tools/cmd/gorename@latest
go install golang.org/x/tools/cmd/guru@latest
go install golang.org/x/tools/gopls@latest

# 安装并启动seafile
sudo dnf install -y seafile-client

systemctl --user daemon-reload
systemctl --user enable seafile
systemctl --user start seafile

seaf-cli sync -l "3440279a-fd36-4e94-bc0e-d3da402a1e58" -s "{{ (bitwardenFields "item" "b27f7204-9341-4396-804e-aff9002a478a").url.value }}" -d ~/Dropbox -u "{{ (bitwardenFields "item" "b27f7204-9341-4396-804e-aff9002a478a").user.value }}" -p "{{ (bitwardenFields "item" "b27f7204-9341-4396-804e-aff9002a478a").password.value }}"
