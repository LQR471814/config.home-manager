STAT_NET="/tmp/sandbar-stat-net"

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

bar_network_watcher() {
  dbus-monitor --system "interface='org.freedesktop.NetworkManager'" | \
  while read -r line; do
    bar_network
    bar
  done
}

