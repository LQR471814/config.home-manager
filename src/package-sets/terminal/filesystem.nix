{
  pkgs ? import <nixpkgs> { },
  ...
}:
with pkgs;
[
  yazi
  rclone
  tree
  dust
  sshfs
  watchman
  broot
  file
]
