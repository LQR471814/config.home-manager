{
  pkgs ? import <nixpkgs> { },
  ...
}:
let
  inherit (pkgs) wlvncc;
in
[
  # rustdesk-flutter
  wlvncc
]
