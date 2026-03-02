{
  pkgs ? import <nixpkgs> { },
  ...
}:
with pkgs;
[
  mprocs
]
