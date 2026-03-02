{
  pkgs ? import <nixpkgs> { },
  ...
}:
with pkgs;
[
  rustdesk-flutter
  wlvncc
]
