export def format []: nothing -> string {
  let conname = (
    nmcli -t -f active,ssid dev wifi
    | lines
    | where {|line| $line | str starts-with "yes:" }
    | first
    | default ""
    | str replace "yes:" ""
  )

  let conname = if $conname == "" {
    let device = (
      nmcli -t -f DEVICE connection show --active
      | lines
      | first
      | default ""
    )

    if $device != "" and $device != lo {
      "Ethernet"
    } else {
      ""
    }
  } else {
    $conname
  }

  if $conname == "" {
    "🌐 Not connected"
  } else {
    $"🌐 ($conname)"
  }
}

export def watcher [] {
  for ev in (dbus-monitor --system "interface='org.freedesktop.NetworkManager'" | lines) {
    {module: network format: (format)} | job send 0
  }
}
