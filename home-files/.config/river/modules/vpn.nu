const VPN_STATUS_FILE = "/home/lqr471814/.vpn-status"

export def format []: nothing -> string {
  let enabled = (open $VPN_STATUS_FILE | str trim) == "1"
  if $enabled {
    "🔐VPN"
  } else {
    "🔓VPN"
  }
}

export def watcher [] {
  loop {
    inotifywait $VPN_STATUS_FILE
    {module: vpn format: (format)} | job send 0
  }
}
