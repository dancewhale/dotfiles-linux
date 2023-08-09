#!/usr/bin/env zsh

# ls to lsd
#alias l='lsd --hyperlink=auto'
#alias ls='lsd -l --hyperlink=auto'
#alias la='lsd -lA --hyperlink=auto'
#alias lt='lsd --tree --hyperlink=auto'
#alias lx='lsd -lXh --hyperlink=auto'                 # sort by extension
#alias lk='lsd -lSrh --hyperlink=auto'                # sort by size
#alias lc='lsd -ltrh --hyperlink=auto'                # sort by date
#alias lf='lsd -l --hyperlink=auto| grep -v '^d''     # files only
#alias ld='lsd -l --hyperlink=auto| grep '^d''        # directories only
alias l.='lsd -A $* | grep "^\."'                    # list hidden files

# list cheatsheets for tools
alias ltp='lsd --tree --hyperlink=auto ~/workspace/cheats/pentest'    # pentest tools
alias ltw='lsd --tree --hyperlink=auto ~/workspace/cheats/web-app'    # web app tools
alias ltr='lsd --tree --hyperlink=auto ~/workspace/cheats/red-team'   # red team tools
alias ltf='lsd --tree --hyperlink=auto ~/workspace/cheats/forensics'  # forensics tools
alias lto='lsd --tree --hyperlink=auto ~/workspace/cheats/other'      # other tools

# diff kitten
alias diff="kitty +kitten diff"
alias gdiff="git difftool --no-symlinks --dir-diff"

# ssh kitten
alias s="kitty +kitten ssh"

# aliases to modified commands
alias mkdir="mkdir -p"
alias ping="prettyping -c 3"
alias less="less -R"
alias kill='killall -q'
alias kgnome='killall -3 gnome-shell'
alias sv="sudo nvim"
alias v="nvim"
alias vim="nvim"
alias tr="trash"
alias fetch='clear && neofetch && fortune ~/.config/fortune/quotes'
alias nfetch='clear && neofetch --kitty ~/pictures/bateman.png && fortune ~/.config/fortune/quotes'
alias devil="fortune ~/.config/fortune/quotes | cowsay -f eyes | lolcat"
alias cmatrix="cmatrix -a"
alias asciiquarium="asciiquarium --transparent"
alias df="df -h"     # human-readable sizes
alias free="free -m" # show sizes in MB
alias ncmpcpp="ncmpcpp ncmpcpp_directory=$HOME/.config/ncmpcpp/"
alias h2t="html2text -style pretty"
alias x2h="xsltproc -o result.html"
alias emc="emacsclient -c -a emacs"
alias d="sudo docker"
alias biggest="du -h --max-depth=1 | sort -h"
alias norg="gron --ungron"
alias ungron="gron --ungron"
alias open='xdg-open'

# mpv
alias mpk='mpv --profile=sw-fast --vo=kitty'
alias mpvadd='mpv --ytdl'
alias mpvpl='mpv "$(yt-dlp -g --flat-playlist "$1")"'
alias mpa='mpv --no-video'
alias mpapl='mpv --no-video "$(yt-dlp -g -x --audio-format mp3 --flat-playlist "$1")"'
alias mpvcwd='mpv ./*.mp4'

# alias to show the date
alias da='date "+%Y-%m-%d %A %T %Z"'

# add new fonts
alias update-fc='sudo fc-cache -fv'

# trans
alias tre='trans en:pl'
alias trp='trans pl:en'

# check vulnerabilities microcode
alias microcode='grep . /sys/devices/system/cpu/vulnerabilities/*'

# recent installed packages
alias rip="expac --timefmt='%Y-%m-%d %T' '%l\t%n %v' | sort | tail -200 | nl"
alias riplong="expac --timefmt='%Y-%m-%d %T' '%l\t%n %v' | sort | tail -3000 | nl"
alias big="expac -H M '%m\t%n' | sort -h | nl"
alias gitpkg="pacman -Q | grep -i '\-git' | wc -l"

# blackarch repo packages
alias blackall="sudo pacman -Sgg | grep blackarch | cut -d' ' -f2 | sort -u"  # list all available tools
alias blackcat="sudo pacman -Sg | grep blackarch"                             # see the blackarch categories

# get the error messages from journalctl
alias jctl="journalctl -p 3 -xb"

# gpg
# verify signature for isos
alias gpg-check="gpg2 --keyserver-options auto-key-retrieve --verify"
alias fix-gpg-check="gpg2 --keyserver-options auto-key-retrieve --verify"
# receive the key
alias gpg-retrieve="gpg2 --keyserver-options auto-key-retrieve --receive-keys"
alias fix-gpg-retrieve="gpg2 --keyserver-options auto-key-retrieve --receive-keys"
alias fix-keyserver="[ -d ~/.gnupg ] || mkdir ~/.gnupg ; cp /etc/pacman.d/gnupg/gpg. conf ~/.gnupg/ ; echo 'done'"

# hblock (stop tracking with hblock) - use unhblock to stop using hblock
alias unhblock="hblock -S none -D none"

# systeminfo
alias probe="sudo -E hw-probe -all -upload"
alias sysfailed="systemctl list-units --failed"
alias ncdu="ncdu --color dark"
alias hw="hwinfo --short"

# count all files (recursively) in the current folder
alias cf="bash -c \"for t in files links directories; do echo \\\$(find . -  type \\\${t:0:1} | wc -l) \\\$t; done 2> /dev/null\""

# show current network connections to the server
alias ipview="netstat -anpl | grep :80 | awk {'print \$5'} | cut -d\":\" -f1 | sort  | uniq -c | sort -n | sed -e 's/^ *//' -e 's/ *\$//'"
alias wlo1='echo $(ifconfig wlo1 | rg "inet " | cut -b 9- | cut  -d" " -f2)'
alias tun0='echo $(ifconfig tun0 | rg "inet " | cut -b 9- | cut  -d" " -f2)'
 
# show open ports
alias openports='netstat -nape --inet'

# aliases to show disk space and space used in a folder
alias diskspace="du -S | sort -n -r |less -R"
alias folders='du -h --max-depth=1'
alias folderssort='find . -maxdepth 1 -type d -print0 | xargs -0 du -sk | sort -rn'
alias tree='tree -CAhF --dirsfirst'
alias treed='tree -CAFd'
alias mountedinfo='df -hT'

# show all logs in /var/log
alias logs="sudo find /var/log -type f -exec file {} \; | grep 'text' | cut -d' ' -  f1 | sed -e's/:\$//g' | grep -v '[0-9]\$' | xargs tail -f"

# usefull
alias cats='highlight -O ansi --force'
alias cat='bat --paging=never --theme OneHalfDark'
alias bat='bat --paging=never --theme OneHalfDark'
alias icat='kitty +kitten icat'
alias ..="cd ../"
alias ...="cd ../../"
alias ....="cd ../../../"

# prettify help/cheat pages
alias bathelp='bat --plain --language=help'
alias ce='cheat --edit'
c() {
  command cheat "$@" | bat --plain --language=help
}
help() {
    "$@" --help 2>&1 | bathelp
}
h() {
    "$@" --help 2>&1 | bathelp
}

# other
alias tks='tmux kill-server'                               # tmux
alias wget='wget --hsts-file="$XDG_DATA_HOME/wget-hsts"'   # wget
alias digs='dig +short'                                    # dig

# git
alias ga="git add"
alias gc="git commit"
alias gp="git push"
alias gitu='git add . && git commit && git push'
alias rmgitcache="rm -r ~/.cache/git"
alias gcm="git checkout master"
alias gcs="git checkout stable"
alias gcd="cloneit"

# pacman and yay
alias pacs="sudo pacman -S"                      # install package faster
alias pacr="sudo pacman -Rns"                    # remove package faster
alias pacf="sudo pacman -F"                      # search binary package faster
alias yayr="yay -Rns"                            # remove package faster
alias yays="yay -S"                              # install AUR package faster
alias yayf="yay -F"                              # search binary package faster
alias pacsyu="sudo pacman -Syu"                  # update only standard pkgs
alias pacsyyu="sudo pacman -Syyu"                # refresh pkglist & update standard pkgs
alias yaysua="yay -Sua --noconfirm"              # update only AUR pkgs (yay)
alias yaysyu="yay -Syu --noconfirm"              # update standard pkgs and AUR pkgs (yay)
alias fixpac="sudo rm /var/lib/pacman/db.lck"    # remove pacman lock
alias cleanup="sudo pacman -Rns (pacman -Qtdq)"  # cleanup orphaned packages

# quick access to config files
alias zshrc="nvim ~/.config/zsh/.zshrc"
alias zshenv="nvim ~/.config/zsh/.zshenv"
alias zsh-scripts="nvim ~/.config/zsh/zsh-scripts"
alias aliases="nvim ~/.config/zsh/aliases.zsh"
alias keybinds="nvim ~/.config/hypr/configs/keybinds.conf"
alias hyprland="nvim ~/.config/hypr/hyprland.conf"
alias vmaps="nvim ~/.config/nvim/lua/core/keymaps.lua"
alias vplugs="nvim ~/.config/nvim/lua/core/plugins.lua"

# colorize grep output
alias grep="grep --color=auto"
alias egrep="egrep --color=auto"
alias fgrep="fgrep --color=auto"
#search content with ripgrep
alias rg="rg --sort path"

# nmap
alias nmap_open="nmap --open"
alias nmap_list_interfaces="nmap --iflist"
alias nmap_slow="sudo nmap -sS -v -T1"
alias nmap_fin="sudo nmap -sF -v"
alias nmap_full="sudo nmap -sS -T4 -PE -PP -PS80,443 -PY -g 53 -A -p1-65535 -v"
alias nmap_check_for_firewall="sudo nmap -sA -p1-65535 -v -T4"
alias nmap_ping_through_firewall="nmap -PS -PA"
alias nmap_fast="nmap -F -T5 --version-light --top-ports 300"
alias nmap_detect_versions="sudo nmap -sV -p1-65535 -O --osscan-guess -T4 -Pn"
alias nmap_check_for_vulns="nmap --script=vuln"
alias nmap_full_udp="sudo nmap -sS -sU -T4 -A -v -PE -PS22,25,80 -PA21,23,80,443,3389 "
alias nmap_traceroute="sudo nmap -sP -PE -PS22,25,80 -PA21,23,80,3389 -PU -PO --traceroute "
alias nmap_full_with_scripts="sudo nmap -sS -sU -T4 -A -v -PE -PP -PS21,22,23,25,80,113,31339 -PA80,113,443,10042 -PO --script all " 
alias nmap_web_safe_osscan="sudo nmap -p 80,443 -O -v --osscan-guess --fuzzy "
alias nmap_ping="nmap -n -sP"

# amass config alias
alias Amass='amass enum -config ~/.config/amass/config.ini -d $1'

# search running processes
alias psa="ps auxf"
alias psrg="ps aux | grep -v grep | grep -i -e VSZ -e"
alias psmem="ps auxf | sort -nr -k 4"
alias psmem10="ps auxf | sort -nr -k 4 | head -10"
alias pscpu="ps auxf | sort -nr -k 3"
alias topcpu="/bin/ps -eo pcpu,pid,user,args | sort -k 1 -r | head -10"
alias psnet="ss -tp | grep -v Recv-Q | sed -e 's/.*users:(("//' -e 's/".*$//' | sort | uniq"

# Zsh Directory Stack
alias d='dirs -v'
for index ({1..9}) alias "$index"="cd +${index}"; unset index
