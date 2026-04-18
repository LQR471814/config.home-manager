source ./modules/date.sh
source ./modules/sound.sh
source ./modules/battery.sh
source ./modules/network.sh

PIPE_BAR=$(make_events "/tmp/sandbar")

bar() {
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

  echo "all status $status" > $PIPE_BAR
}

bar_watchers() {
  bar_date_watcher &
  bar_sound_watcher &
  bar_battery_watcher &
  bar_network_watcher &
}

bar_refresh() {
  bar_date
  bar_battery
  bar_network
  bar_sound
  bar
}

bar_sandbar() {
  while true; do
    flush_pipe "$PIPE_BAR" | sandbar -no-layout -hide-normal-mode -font "IBM Plex Mono" -scale 2
    sleep 1
  done
}
