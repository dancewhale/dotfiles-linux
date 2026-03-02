#!/bin/bash

# 获取当前焦点所在的显示器名称
get_active_display() {
    # 使用 xrandr 查询活动显示器（假设使用 Xorg）
    local active_display=$(xrandr --listactivemonitors | awk '/Monitors:/ {next} NR>1 {print $4}')
    
    # 转换显示器名称格式（示例：替换空格和下划线）
    echo "${active_display// /_}"
}

# 获取当前显示器名称
DISPLAY_NAME=$(get_active_display)

# 如果没有检测到，使用默认名称
[ -z "$DISPLAY_NAME" ] && DISPLAY_NAME="default"

# 执行 kitten 命令
kitten quick-access-terminal \
    --detach \
    --override "output_name=${DISPLAY_NAME}" \
    -o "edge=center"  \
    -o "margin_left=250" \
    -o "margin_right=250" \
    -o "margin_bottom=900" \

echo "已在显示器 [$DISPLAY_NAME] 上启动下拉终端"

