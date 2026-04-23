{
  pkgs ? import <nixpkgs> { },
  ...
}:
with pkgs;
[
  rclone
  tree
  dust
  sshfs
  watchman
  broot
  file
]
