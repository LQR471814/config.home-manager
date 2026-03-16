{
  pkgs ? import <nixpkgs> { },
  ...
}:
with pkgs;
[
  lean4
]
