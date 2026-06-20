export def format []: nothing -> string {
  let text = wpctl get-volume @DEFAULT_AUDIO_SINK@

  let muted: bool = $text | str contains "[MUTED]"
  if $muted { return 🔇 }

  let vol_text = $text | parse "{_} {vol}" | get --optional 0.vol
  let volume = (($vol_text | into float) * 100) | math floor

  if $muted {
    🔇
  } else if $volume > 0 and $volume <= 33 {
    $"🔈 ($volume)%"
  } else if $volume > 33 and $volume <= 66 {
    $"🔉 ($volume)%"
  } else {
    $"🔊 ($volume)%"
  }
}

const SOUND_EVENTS = "/tmp/sandbar-sound"

export def watcher [] {
  rm --force $SOUND_EVENTS
  mkfifo $SOUND_EVENTS

  loop {
    open --raw $SOUND_EVENTS
    {module: sound format: (format)} | job send 0
  }
}
