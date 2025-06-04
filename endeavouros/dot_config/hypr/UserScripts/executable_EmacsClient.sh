#!/bin/bash

# 检查窗口是否存在
window_exists() {
    hyprctl clients -j | jq -e '.[] | select((.class=="EmacsSystem" or .title=="EmacsSystem"))' > /dev/null
}

# 创建 EmacsDrop 窗口
create_drop_window() {
    emacsclient -c --frame-parameters='(quote (name . "EmacsDrop"))' -e '(cyz-display-init)'
}

# 创建 EmacsSystem 窗口并打开文件
create_system_window() {
    local num="$1"
    local filepath="$2"
    emacsclient -c --frame-parameters='(quote (name . "EmacsSystem"))' -n  "+$num" "$filepath"
}

# 在EmacsSystem 窗口中打开文件
open_system_window() {
    local num="$1"
    local filepath="$2"
    emacsclient -n "+$num" "$filepath"
}



# 切换到 EmacsSystem 窗口
focus_system_window() {
#    local address
#    address=$(hyprctl clients -j | jq -r '.[] | select((.class=="EmacsSystem" or .title=="EmacsSystem")) | .address' | head -n1)
#    if [[ -n "$address" ]]; then
#        hyprctl dispatch focuswindow "$address"
#    fi
     hyprctl dispatch workspace 2
}

# 主逻辑
if [[ "$1" == "--drop" ]]; then
    create_drop_window
elif [[ "$1" == "--file" && -n "$2" && "$3" == "--num" && -n "$4" ]]; then
    filepath="$2"
    num="$4"
    if ! window_exists; then
        create_system_window "$num" "$filepath"
    fi
    if window_exists; then
        open_system_window "$num" "$filepath"
    fi
    focus_system_window
else
    echo "用法:"
    echo "  $0 --drop"
    echo "  $0 --file <filepath> --num <num>"
    exit 1
fi
