export def format []: nothing -> oneof<string, nothing> {
  let charge = try { open /sys/class/power_supply/BAT0/capacity | str trim } catch { null }
  let status = try { open /sys/class/power_supply/BAT0/status | str trim } catch { null }

  if $charge == null or $status == null {
    return null
  }

  if $status == "" {
    "🔌 Wired"
  } else if $status == "Charging" {
    $"🔌 ($charge)% ($status)"
  } else {
    $"🔋 ($charge)% ($status)"
  }
}

export def watcher [] {
  mut last_exec = 0.0

  for ev in (upower -m | lines) {
    let now = (date now | format date %s.%f | into float)
    let elapsed = ($now - $last_exec)

    if $elapsed >= 0.5 {
      {module: battery format: (format)} | job send 0
      $last_exec = $now
    }
  }
}
