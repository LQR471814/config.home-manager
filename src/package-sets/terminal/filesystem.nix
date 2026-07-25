{
  pkgs ? import <nixpkgs> { },
  ...
}:
let
  inherit (pkgs)
    rclone
    tree
    dust
    sshfs
    watchman
    file
    ;
in
[
  rclone
  tree
  dust
  sshfs
  watchman
  file
]
