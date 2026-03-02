{
  pkgs ? import <nixpkgs> { },
  ...
}:
with pkgs;
[
  htop
  btop
  powertop
]
