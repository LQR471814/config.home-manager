#!/usr/bin/env nu
def main [path: string cmd: string] {
  let base = $path | path basename

  let existing = tmux ls
    | complete
    | get stdout
    | parse --regex $"\(?m\)^($base)\([^:]*\)"

  let session = if ($existing | is-not-empty) {
    $existing
    | str join "\n"
    | fzf --layout=reverse
  } else {
    $base
  }

  tmux new-session -A -c $path -s $session $cmd
  null
}
