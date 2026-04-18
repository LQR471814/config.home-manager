STAT_BAT="/tmp/sandbar-stat-bat"

bar_battery() {
  # Change BAT1 to whatever your battery is identified as. Typically BAT0 or BAT1
  local CHARGE=$(cat /sys/class/power_supply/BAT0/capacity 2>/dev/null)
  local STATUS=$(cat /sys/class/power_supply/BAT0/status 2>/dev/null)

  if [ "$STATUS" = "" ]; then
    "🔌 Wired" > $STAT_BAT
  elif [ "$STATUS" = "Charging" ]; then
    printf "🔌 %s%% %s" "$CHARGE" "$STATUS" > $STAT_BAT
  else
    printf "🔋 %s%% %s" "$CHARGE" "$STATUS" > $STAT_BAT
  fi
}

bar_battery_watcher() {
  local last_exec=0
  upower -m | \
  while read -r line; do
    local now=$(date +%s.%N)
    local elapsed=$(echo "$now - $last_exec" | bc)

    if test -n "${debounce_pid}" && ps -p "${debounce_pid}" > /dev/null; then
      kill "${debounce_pid}"
    fi

    if [ "$(echo "$elapsed >= 0.5" | bc -l)" = "1" ]; then
      bar_battery
      bar
      last_exec="$now"
    fi
  done
}

