#!/bin/bash

# Files
CONFIG="$HOME/.config/rofi/config"
STYLE="$HOME/.config/rofi/style.css"
#COLORS="$HOME/.config/rofi/colors"

# Wofi Command
wofi_command="wofi --show dmenu \
      --conf ${CONFIG} --style ${STYLE} --color ${COLORS} \
      --width=350 --height=380 \
      --cache-file=/dev/null \
      --hide-scroll --no-actions \
      --prompt "Search live streams"
      --define=matching=fuzzy"


notification(){
  notify-send "Lofi Stream" "Now Playing: Lofi Radio"
}

menu(){
  printf "1. Lofi Girl\n"
  printf "2. Chillhop\n"
  printf "3. Box Lofi\n"
  printf "4. The Bootleg Boy\n"
  printf "5. Radio Spinner\n"
  printf "6. SmoothChill\n"
  printf "7. Little Soul\n"
  printf "8. Fasetya\n"
  printf "9. Lofi Zone"
}

main() {
  choice=$(menu | ${wofi_command} | cut -d. -f1)

  case $choice in
    1)
      notification
      mpv "https://play.streamafrica.net/lofiradio"
      return
      ;;
    2)
      notification
      mpv "http://stream.zeno.fm/fyn8eh3h5f8uv"
      return
      ;;
    3)
      notification
      mpv "http://stream.zeno.fm/f3wvbbqmdg8uv"
      return
      ;;
    4)
      notification ;
      mpv "http://stream.zeno.fm/0r0xa792kwzuv"
      return
      ;;
    5)
      notification ;
      mpv "https://live.radiospinner.com/lofi-hip-hop-64"
      return
      ;;
    6)
      notification ;
      mpv "https://media-ssl.musicradio.com/SmoothChill"
      return
      ;;
    7)
      notification ;
      mpv --vid=no "https://www.youtube.com/watch?v=NiOxSuEJaTI"
      return
      ;;
    8)
      notification ;
      mpv --shuffle --ytdl-raw-options="cookies=/tmp/cookies.txt" --vid=no https://www.youtube.com/playlist\?list\=PLusoefCj_Mkn6dRQMc3MxUGFHLeYT4y49
      return
      ;;
    9)
      notification ;
      mpv --shuffle --ytdl-raw-options="cookies=/tmp/cookies.txt" --vid=no https://www.youtube.com/watch?v=GaW13eDQO6s
      return
      ;;
  esac
}

pkill -f http && notify-send "Lofi Stream" "Lofi Radio stopped" || main
