#!/bin/bash

# 获取当前焦点所在的显示器名称
get_active_display() {
    # 使用 xrandr 查询活动显示器（假设使用 Xorg）
    local active_display=$(xrandr --listactivemonitors | awk '/Monitors:/ {next} NR>1 {print $4}')
    
    # 转换显示器名称格式（示例：替换空格和下划线）
    echo "${active_display// /_}"
}

get_display_margin() {
    # ====== 配置区 ======
    # 百分比，0-50
    left_margin=15       # 左边空白百分比
    right_margin=15      # 右边空白百分比
    bottom_margin=50     # 下方空白百分比
    # ====== 获取屏幕分辨率 ======
    # 获取主屏幕分辨率（适用于Xorg，Wayland下请手动指定或改用其它命令）
    screen_info=$(xrandr | awk '/ connected primary/ {print $4}')
    # 若没“primary”可手动挑一个输出，如：
    # screen_info=$(xrandr | awk '/ connected/ {print $3; exit}')
    resolution=$(echo $screen_info | grep -o '[0-9]\+x[0-9]\+')
    width=${resolution%x*}
    height=${resolution#*x}
    # ====== 百分比转像素 ======
    left_px=$(printf "%.0f" "$(echo "$width * $left_margin / 100" | bc -l)")
    right_px=$(printf "%.0f" "$(echo "$width * $right_margin / 100" | bc -l)")
    bottom_px=$(printf "%.0f" "$(echo "$height * $bottom_margin / 100" | bc -l)")
    # ====== 输出结果 ======
    echo "屏幕分辨率: ${width}x${height}"
    echo "左边空白: ${left_margin}% = ${left_px} px"
    echo "右边空白: ${right_margin}% = ${right_px} px"
    echo "下边空白: ${bottom_margin}% = ${bottom_px} px"
}

# 获取当前显示器名称
DISPLAY_NAME=$(get_active_display)

get_display_margin

# 如果没有检测到，使用默认名称
[ -z "$DISPLAY_NAME" ] && DISPLAY_NAME="default"

# 执行 kitten 命令
kitten quick-access-terminal \
    --detach \
    --override "output_name=${DISPLAY_NAME}" \
    -o "edge=center"  \
    -o "margin_left=${left_px}" \
    -o "margin_right=${right_px}" \
    -o "margin_bottom=${bottom_px}" \

echo "已在显示器 [$DISPLAY_NAME] 上启动下拉终端"

