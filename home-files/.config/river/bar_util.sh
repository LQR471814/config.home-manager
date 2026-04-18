# $1: pipe path
# STDOUT: pipe path
make_events() {
  if [ ! -p "$1" ]; then
    mkfifo "$1"
  fi
  echo "$1"
}

# $1: pipe path
# $2: handler
listen_events() {
  while cat "$1"; do
    "$2"
  done
}

# $1: pipe path
# STDOUT: currently buffered contents
flush_pipe() {
  while cat "$1"; do :; done
}

