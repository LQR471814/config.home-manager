export def format []: nothing -> string {
  let current = (brightnessctl get | into int)
  let max = (brightnessctl max | into int)
  let percent = (($current * 100 / $max) | math round)

  if $percent >= 0 and $percent < 20 {
    $"🌑 ($percent)%"
  } else if $percent >= 20 and $percent < 40 {
    $"🌒 ($percent)%"
  } else if $percent >= 40 and $percent < 60 {
    $"🌓 ($percent)%"
  } else if $percent >= 60 and $percent < 80 {
    $"🌔 ($percent)%"
  } else if $percent >= 80 and $percent <= 100 {
    $"🌕 ($percent)%"
  } else {
    "???"
  }
}

const BRIGHTNESS_EVENTS = "/tmp/sandbar-brightness"

export def watcher []: nothing -> nothing {
  rm --force $BRIGHTNESS_EVENTS
  mkfifo $BRIGHTNESS_EVENTS

  loop {
    open --raw $BRIGHTNESS_EVENTS
    {module: brightness format: (format)} | job send 0
  }
}
