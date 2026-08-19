#!/usr/bin/env nu
def main [path: string cmd: string] {
  let path = $path | path expand
  let base = $path | path basename
  tmux new-session -A -c $path -s $base $cmd
  null
}
