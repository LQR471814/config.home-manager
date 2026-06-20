export def format []: nothing -> string {
  $"📆 (date now | format date '%a %m-%d-%y %T')"
}

export def watcher [] {
  while true {
    {module: clock format: (format)} | job send 0
    sleep 1sec
  }
}
