{
  pkgs ? import <nixpkgs> { },
  ...
}:
with pkgs;
[
  tlaplusToolbox
  tlaplus
]
