{
  pkgs ? import <nixpkgs> { },
  ...
}:
with pkgs;
[
  playerctl
  zenity
  wayland-pipewire-idle-inhibit
]
