STAT_DATE="/tmp/sandbar-stat-date"

bar_date() {
  printf "📆 %s" "$(date "+%a %m-%d-%y %T")" > $STAT_DATE
}

bar_date_watcher() {
  while true; do
    sleep 1
    bar_date
    bar
  done
}

