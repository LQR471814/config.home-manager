#!/usr/bin/env nu

def "take screenshot" [] {
  let dst = [
    $env.HOME
    (date now | format date '%Y%m%d_%Hh%Mm%Ss_shot.png')
  ] | path join

  wayfreeze --after-freeze-cmd $"grim -g \"$\(slurp\)\" \"($dst)\"; killall wayfreeze"
  | complete

  open $dst | wl-copy
}

let screenshot_status_path: path = $env.HOME | path join ".screenshot.active"
if ($screenshot_status_path | path exists) {
  return
}
"" | save -f $screenshot_status_path

try {
  take screenshot
} catch { }

rm -f $screenshot_status_path
