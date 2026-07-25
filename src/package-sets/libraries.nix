{
  pkgs ? import <nixpkgs> { },
  ...
}:
let
  inherit (pkgs)
    openssl
    libGL
    libnotify
    inotify-tools
    ;
in
[
  openssl
  libGL
  libnotify
  inotify-tools
]
