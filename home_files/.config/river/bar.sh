#!/bin/sh

STAT_BAT="/tmp/sandbar-stat-bat"
STAT_NET="/tmp/sandbar-stat-net"
STAT_SOUND="/tmp/sandbar-stat-sound"
STAT_DATE="/tmp/sandbar-stat-date"

FIFO_BAR="/tmp/sandbar"

bar_display() {
  local stat_net="$(< $STAT_NET)"
  local stat_sound="$(< $STAT_SOUND)"
  local stat_bat="$(< $STAT_BAT)"
  local stat_date="$(< $STAT_DATE)"

  local status=""
  if [ "$stat_net" != "" ]; then
    status="$status  $stat_net"
  fi
  if [ "$stat_sound" != "" ]; then
    status="$status  $stat_sound"
  fi
  if [ "$stat_bat" != "" ]; then
    status="$status  $stat_bat"
  fi
  if [ "$stat_date" != "" ]; then
    status="$status  $stat_date"
  fi
  # remove prefix is present
  case "$status" in
    "  "*) status="${status#??}" ;;
  esac

  echo "all status $status" > $FIFO_BAR
}

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

bar_network() {
  local CONNAME=$(nmcli -t -f active,ssid dev wifi | grep '^yes' | cut -c 5-)
  if [ "$CONNAME" = "" ]; then
    local DEVICE=$(nmcli -t -f DEVICE connection show --active | awk 'NR==1 {print $1}')
    if [ "$DEVICE" != "lo" ]; then
      CONNAME="Ethernet"
    fi
  fi

  if [ "$CONNAME" = "" ]; then
    echo "🌐 Not connected" > $STAT_NET
  else
    echo "🌐 ${CONNAME}" > $STAT_NET
  fi
}

bar_sound() {
  local STATUS=$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | awk '{print $3}')

  local raw_vol=$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | awk '{print $2}')
  local percent_vol=$(echo "scale=0; $raw_vol * 100" | bc)
  local VOL="${percent_vol%.*}"

  if [ "$STATUS" = "[MUTED]" ]; then
    echo "🔇" > $STAT_SOUND
  else
    if [ "$VOL" -gt 0 ] && [ "$VOL" -le 33 ]; then
      printf "🔈 %s%%" "$VOL" > $STAT_SOUND
    elif [ "$VOL" -gt 33 ] && [ "$VOL" -le 66 ]; then
      printf "🔉 %s%%" "$VOL" > $STAT_SOUND
    else
      printf "🔊 %s%%" "$VOL" > $STAT_SOUND
    fi
  fi
}

bar_date() {
  printf "📆 %s" "$(date "+%a %m-%d-%y %T")" > $STAT_DATE
}

battery_watcher() {
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
      bar_display
      last_exec="$now"
    fi
  done
}

network_watcher() {
  dbus-monitor --system "interface='org.freedesktop.NetworkManager'" | \
  while read -r line; do
    bar_network
    bar_display
  done
}

date_watcher() {
  while true; do
    sleep 1
    bar_date
    bar_display
  done
}

FIFO_SOUND="/tmp/sandbar-sound"

sound_watcher() {
  while cat $FIFO_SOUND; do
    bar_sound
    bar_display
  done
}

if [ ! -p $FIFO_SOUND ]; then
  mkfifo $FIFO_SOUND
fi

if [ ! -p $FIFO_BAR ]; then
  mkfifo $FIFO_BAR
fi

sandbard() {
  while cat $FIFO_BAR; do :; done | sandbar -no-layout -hide-normal-mode -font "IBM Plex Mono" -scale 2
}

sandbard &
battery_watcher &
network_watcher &
date_watcher &
sound_watcher &

# initial run
bar_date
bar_battery
bar_display
bar_network
bar_display

sleep 0.5 # to somewhat avoid race condition
bar_sound

wait
