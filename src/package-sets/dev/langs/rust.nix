{
  pkgs ? import <nixpkgs> { },
  ...
}:
with pkgs;
[
  cargo
  rustc
]
