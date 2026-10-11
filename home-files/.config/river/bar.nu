use ./modules/battery.nu
use ./modules/brightness.nu
use ./modules/clock.nu
use ./modules/network.nu
use ./modules/sound.nu
use ./modules/vpn.nu

def "spawn watchers" []: nothing -> nothing {
  job spawn { battery watcher }
  job spawn { brightness watcher }
  job spawn { clock watcher }
  job spawn { network watcher }
  job spawn { sound watcher }
  job spawn { vpn watcher }
  null
}

const SANDBAR_INPUT = "/tmp/sandbar-input"

def "spawn sandbar" []: nothing -> int {
  rm --force $SANDBAR_INPUT
  mkfifo $SANDBAR_INPUT | complete

  job spawn {
    open $SANDBAR_INPUT --raw | sandbar -no-layout -hide-normal-mode -font "IBM Plex Mono" -scale 2
  }

  job spawn {
    null
    generate {|inp|
      let e = job recv
      {out: $"all status ($e)\n" next: ($inp | append $e)}
    } []
    | str join ""
    | ^tee $SANDBAR_INPUT
  }
}

def "format modules" []: list<string> -> string {
  where $it != null
  | str join "  "
}

def main [] {
  print "initializing bar..."

  let status_updater = spawn sandbar
  spawn watchers

  mut state = {}

  $state.battery = battery format
  $state.brightness = brightness format
  $state.clock = clock format
  $state.network = network format
  $state.sound = sound format
  $state.vpn = vpn format

  let modules_ordering = {|state|
    [
      $state.vpn
      $state.network
      $state.brightness
      $state.sound
      $state.battery
      $state.clock
    ]
  }

  do $modules_ordering $state
  | format modules
  | job send $status_updater

  while true {
    let payload = job recv

    $state = $state
      | update $payload.module { $payload.format }

    do $modules_ordering $state
    | format modules
    | job send $status_updater
  }
}
