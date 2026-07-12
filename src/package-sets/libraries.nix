{
  pkgs ? import <nixpkgs> { },
  ...
}:
with pkgs;
[
  openssl
  libGL
  libnotify
  inotify-tools
]
