{
  pkgs ? import <nixpkgs> { },
  ...
}:
with pkgs;
[
  nixd
  nixfmt
]
