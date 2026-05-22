source ./modules/date.sh
source ./modules/sound.sh
source ./modules/battery.sh
source ./modules/network.sh
source ./modules/brightness.sh

PIPE_BAR=$(make_events "/tmp/sandbar")

bar() {
  local stat_net="$(< $STAT_NET)"
  local stat_sound="$(< $STAT_SOUND)"
  local stat_brightness="$(< $STAT_BRIGHTNESS)"
  local stat_bat="$(< $STAT_BAT)"
  local stat_date="$(< $STAT_DATE)"
  set -- "$stat_net" "$stat_brightness" "$stat_sound" "$stat_bat" "$stat_date"

  local status=""
  for stat; do
    if [ "$stat" != "" ]; then
      status="$status  $stat"
    fi
  done

  # remove prefix is present
  case "$status" in
    "  "*) status="${status#??}" ;;
  esac

  echo "all status $status" > $PIPE_BAR
}

bar_watchers() {
  bar_date_watcher &
  bar_sound_watcher &
  bar_brightness_watcher &
  bar_battery_watcher &
  bar_network_watcher &
}

bar_refresh() {
  bar_date
  bar_sound
  bar_brightness
  bar_battery
  bar_network
  bar
}

bar_sandbar() {
  while true; do
    flush_pipe "$PIPE_BAR" | sandbar -no-layout -hide-normal-mode -font "IBM Plex Mono" -scale 2
    sleep 1
  done
}
