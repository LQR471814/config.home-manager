{
  pkgs ? import <nixpkgs> { },
  ...
}:
with pkgs;
[
  tlaplus
]
