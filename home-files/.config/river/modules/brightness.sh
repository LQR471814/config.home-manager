STAT_BRIGHTNESS="/tmp/sandbar-stat-brightness"
PIPE_BRIGHTNESS=$(make_events "/tmp/sandbar-brightness")

bar_brightness() {
  local CURRENT="$(brightnessctl get)"
  local MAX="$(brightnessctl max)"
  local percent="$(echo "scale=0; $CURRENT * 100 / $MAX" | bc -l)"

  if [ "$percent" -ge 0 ] && [ "$percent" -lt 20 ]; then
    printf "🌑 %s%%" "$percent" > "$STAT_BRIGHTNESS"
    printf "%s%%" "$percent" > ~/TEST
  elif [ "$percent" -ge 20 ] && [ "$percent" -lt 40 ]; then
    printf "🌒 %s%%" "$percent" > "$STAT_BRIGHTNESS"
    printf "%s%%" "$percent" > ~/TEST2
  elif [ "$percent" -ge 40 ] && [ "$percent" -lt 60 ]; then
    printf "🌓 %s%%" "$percent" > "$STAT_BRIGHTNESS"
    printf "%s%%" "$percent" > ~/TEST3
  elif [ "$percent" -ge 60 ] && [ "$percent" -lt 80 ]; then
    printf "🌔 %s%%" "$percent" > "$STAT_BRIGHTNESS"
    printf "%s%%" "$percent" > ~/TEST4
  elif [ "$percent" -ge 80 ] && [ "$percent" -lt 100 ]; then
    printf "🌕 %s%%" "$percent" > "$STAT_BRIGHTNESS"
    printf "%s%%" "$percent" > ~/TEST5
  else
    printf "???" > "$STAT_BRIGHTNESS"
  fi
}

bar_brightness_watcher() {
  while cat "$PIPE_BRIGHTNESS" > /dev/null; do
    bar_brightness
    bar
  done
}

