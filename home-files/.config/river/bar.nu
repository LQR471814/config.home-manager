use ./modules/battery.nu
use ./modules/brightness.nu
use ./modules/clock.nu
use ./modules/network.nu
use ./modules/sound.nu

def "spawn watchers" []: nothing -> nothing {
	job spawn {battery watcher}
	job spawn {brightness watcher}
	job spawn {clock watcher}
	job spawn {network watcher}
	job spawn {sound watcher}
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
			{out: $"all status ($e)\n", next: ($inp | append $e)}
		} []
			| str join ""
			| ^tee $SANDBAR_INPUT
	}
}

def "format modules" [
	--battery: string
	--brightness: string
	--clock: string
	--network: string
	--sound: string
]: nothing -> string {
	[
		$network  # nu-lint-ignore: check_typed_flag_before_use
		$brightness  # nu-lint-ignore: check_typed_flag_before_use
		$sound  # nu-lint-ignore: check_typed_flag_before_use
		$battery  # nu-lint-ignore: check_typed_flag_before_use
		$clock  # nu-lint-ignore: check_typed_flag_before_use
	]
		| where $it != null
		| str join "  "
}

def main [] {
	print "initializing bar..."

	let status_updater = spawn sandbar
	spawn watchers

	mut battery = battery format
	mut brightness = brightness format
	mut clock = clock format
	mut network = network format
	mut sound = sound format

	format modules --battery $battery --brightness $brightness --network $network --sound $sound --clock $clock
		| job send $status_updater

	while true {
		let payload = job recv

		match $payload.module {
			battery => { $battery = $payload.format }
			brightness => { $brightness = $payload.format }
			clock => { $clock = $payload.format }
			network => { $network = $payload.format }
			sound => { $sound = $payload.format }
		}

		let text = format modules --battery $battery --brightness $brightness --network $network --sound $sound --clock $clock

		$text | job send $status_updater
	}
}

