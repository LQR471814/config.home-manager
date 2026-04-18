STAT_SOUND="/tmp/sandbar-stat-sound"
PIPE_SOUND=$(make_events "/tmp/sandbar-sound")

bar_sound() {
  local STATUS=$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | awk '{print $3}')
  local raw_vol=$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | awk '{print $2}')
  local percent_vol=$(echo "$raw_vol * 100" | bc)
  local VOL="${percent_vol%.*}"

  if [ "$STATUS" = "[MUTED]" ]; then
    printf "🔇" > $STAT_SOUND
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

bar_sound_watcher() {
  while cat "$PIPE_SOUND"; do
    bar_sound
    bar
  done
}


