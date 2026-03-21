{
  pkgs ? import <nixpkgs> { },
  ...
}:
with pkgs;
[
  elan
]
