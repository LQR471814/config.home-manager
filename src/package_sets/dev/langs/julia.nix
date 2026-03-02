{
  pkgs ? import <nixpkgs> { },
  ...
}:
with pkgs;
[
  julia-bin
]
