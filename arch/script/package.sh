#!/bin/bash -xe

sudo pacman -S --noconfirm cargo gcc make

which cargo && cargo install grex tree-sitter-cli lsd

sudo pacman -S --noconfirm jq tokei bat exa zoxide ripgrep ack the_silver_searcher
sudo pacman -S --noconfirm ack fd calibre

sudo pacman -S --noconfirm fzf docker

sudo pacman -S --noconfirm net-tools

# 代码相关
# shell
paru -Sy shellcheck
sudo pacman -S --noconfirm shfmt

# lisp
sudo pacman -S --noconfirm sbcl
# golang
sudo pacman -S --noconfirm go

go install github.com/acroca/go-symbols@latest
go install github.com/cweill/gotests/gotests@latest
go install github.com/fatih/gomodifytags@main
go install github.com/josharian/impl@latest
go install github.com/ramya-rao-a/go-outline@latest
go install github.com/rogpeppe/godef@latest
go install github.com/sqs/goreturns@latest
go install github.com/nsf/gocode@latest
go install github.com/x-motemen/gore/cmd/gore@latest
go install golang.org/x/tools/cmd/goimports@latest
go install golang.org/x/lint/golint@latest
go install golang.org/x/tools/cmd/gorename@latest
go install golang.org/x/tools/cmd/guru@latest
go install golang.org/x/tools/gopls@latest
go install github.com/go-delve/delve/cmd/dlv@latest

# lsp-bridge
sudo pacman -S --noconfirm python-pip python-maturin python-setuptools \
	python-orjson python-six python-paramiko python-pyte
paru -Sy python-epc python-sexpdata

sudo pacman -S --noconfirm recoll xapian-core

sudo pacman -S zsh zsh-completions cliphist pkgfile bash-completion

# setting zsh
paru -S zsh-theme-powerlevel10k-git jump find-the-command
sudo pacman -S xclip wl-clipboard lsd neovim
