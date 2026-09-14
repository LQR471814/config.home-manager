#!/usr/bin/env nu

def "create session" [path: string cmd: string session_name: string additional_args: list<string>] {
  tmux new-session ...$additional_args -c $path -s $session_name $cmd
}

def main [path: string cmd: string --attach] {
  let path = $path | path expand
  let session_name = $path | path basename

  if $attach {
    create session $path $cmd $session_name [-A]
    return
  }

  let session_names = tmux list-session -F '#{session_name}'
    | lines

  let suffixed_name = 1..
    | each {|suffix| $"($session_name)-($suffix)" }
    | where not ($it in $session_names)
    | first

  create session $path $cmd $suffixed_name []
}
