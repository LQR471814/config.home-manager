{
  pkgs ? import <nixpkgs> { },
  ...
}:
with pkgs;
[
  playerctl
  zenity
  wayland-pipewire-idle-inhibit
  youtube-tui
  mpv

  swaylock
]
