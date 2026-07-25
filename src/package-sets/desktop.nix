{
  pkgs ? import <nixpkgs> { },
  ...
}:
let
  inherit (pkgs)
    playerctl
    zenity
    wayland-pipewire-idle-inhibit
    youtube-tui
    mpv
    darktable
    geeqie
    exiftool
    ;
in
[
  playerctl
  zenity
  wayland-pipewire-idle-inhibit
  youtube-tui
  mpv
  darktable
  geeqie
  exiftool
]
