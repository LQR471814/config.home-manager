{
  pkgs ? import <nixpkgs> { },
  ...
}:
with pkgs;
[
  btop
  powertop
]
