#!/bin/bash -xe

sudo pacman -S --noconfirm cargo gcc make grex lsd \
       	jq tokei bat exa zoxide ripgrep ack the_silver_searcher \
        ack fd calibre fzf docker net-tools shfmt sbcl go  xclip wl-clipboard neovim

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
sudo pacman -S --noconfirm --needed python-pip python-maturin python-setuptools \
	python-orjson python-six python-paramiko python-pyte

paru -S  python-epc python-sexpdata

sudo pacman -S --noconfirm --needed recoll xapian-core

sudo pacman -S --noconfirm --needed zsh zsh-completions cliphist pkgfile bash-completion

# setting zsh
paru -S zsh-theme-powerlevel10k-git jump find-the-command
